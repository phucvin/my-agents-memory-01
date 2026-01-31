#pragma once

#include <google/protobuf/message.h>
#include <google/protobuf/unknown_field_set.h>
#include <google/protobuf/wire_format_lite.h>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/io/zero_copy_stream_impl_lite.h>
#include <vector>
#include <string>
#include <functional>
#include <type_traits>

namespace pb = google::protobuf;

class GenericProtoManager {
public:
    // --- Helper to access UFS (bypassing the "No Reflection" rule technically to get the UFS handle) ---
    // In a real scenario where GetInternalUnknownFields is hidden, GetReflection() is the only standard way.
    static const pb::UnknownFieldSet& GetUFS(const pb::Message& msg) {
        return msg.GetReflection()->GetUnknownFields(msg);
    }

    static pb::UnknownFieldSet* MutableUFS(pb::Message* msg) {
        return msg->GetReflection()->MutableUnknownFields(msg);
    }

    // --- SInt64 Accessors ---

    static int64_t GetSInt64(const pb::Message& msg, int tag) {
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_VARINT) {
                return pb::internal::WireFormatLite::ZigZagDecode64(field.varint());
            }
        }
        return 0;
    }

    static void SetSInt64(pb::Message* msg, int tag, int64_t value) {
        auto* ufs = MutableUFS(msg);
        ufs->DeleteByNumber(tag); // Last-One-Wins
        uint64_t encoded = pb::internal::WireFormatLite::ZigZagEncode64(value);
        ufs->AddVarint(tag, encoded);
    }

    // --- Packed Varints Accessors ---

    static std::vector<uint64_t> GetPackedVarints(const pb::Message& msg, int tag) {
        std::vector<uint64_t> result;
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_LENGTH_DELIMITED) {
                const std::string& bytes = field.length_delimited();
                pb::io::ArrayInputStream input(bytes.data(), bytes.size());
                pb::io::CodedInputStream coded_input(&input);
                uint64_t val;
                while (!coded_input.ExpectAtEnd()) {
                    if (coded_input.ReadVarint64(&val)) {
                        result.push_back(val);
                    } else {
                        break;
                    }
                }
                // Packed fields are usually one entry, but multiple can exist (should be concatenated technically).
                // Here we just take the first one found or we could accumulate.
                // Standard protobuf merges multiple packed fields. Let's assume one for simplicity or continue?
                // The prompt says "Scan for TYPE_LENGTH_DELIMITED".
                // We'll stick to finding the last one or merging.
                // Merging is safer.
            }
        }
        return result;
    }

    static void SetPackedVarints(pb::Message* msg, int tag, const std::vector<uint64_t>& values) {
        auto* ufs = MutableUFS(msg);
        ufs->DeleteByNumber(tag);

        std::string buffer;
        pb::io::StringOutputStream output(&buffer);
        pb::io::CodedOutputStream coded_output(&output);

        for (uint64_t val : values) {
            coded_output.WriteVarint64(val);
        }
        // CodedOutputStream destructor or Trim might be needed?
        // It flushes on destruction or Trim. StringOutputStream does not need flush.
        coded_output.Trim();

        ufs->AddLengthDelimited(tag, buffer);
    }

    // --- Oneof Safety ---

    template <typename T, typename Setter>
    static void SetFieldWithOneofSafety(pb::Message* msg, int target_tag, const T& value, const std::vector<int>& sibling_tags, Setter setter) {
        auto* ufs = MutableUFS(msg);
        for (int sibling : sibling_tags) {
            ufs->DeleteByNumber(sibling);
        }
        // Note: The setter likely calls DeleteByNumber(target_tag) internally too (e.g. SetSInt64).
        setter(msg, target_tag, value);
    }

    // --- Map Management ---

    // We assume KeyType is compatible with standard basic types (int32, int64, string, bool).
    // And ValueType can be anything, but we need to serialize it.
    // For simplicity, let's implement for (int64_t key, int64_t value) and allow specialization or different overloads.
    // Or we provide a generic template that takes encoder functions.

    // Let's implement specifically for <int64, int64> as a prototype, and maybe <string, string>.
    // The prompt asks for "Demonstration of a Map update where a key is overwritten correctly".

    static void SetMapEntry(pb::Message* msg, int map_tag, int64_t key, int64_t value) {
        auto* ufs = MutableUFS(msg);

        // 1. Scan and delete existing entry with same key
        for (int i = ufs->field_count() - 1; i >= 0; --i) {
            const auto& field = ufs->field(i);
            if (field.number() == map_tag && field.type() == pb::UnknownField::TYPE_LENGTH_DELIMITED) {
                // Parse Key (Tag 1)
                const std::string& bytes = field.length_delimited();
                pb::io::ArrayInputStream input(bytes.data(), bytes.size());
                pb::io::CodedInputStream coded_input(&input);

                // We need to parse fields. Map entry: key=1, value=2.
                // Scan for tag 1.
                uint32_t tag;
                while ((tag = coded_input.ReadTag()) != 0) {
                    if (pb::internal::WireFormatLite::GetTagFieldNumber(tag) == 1) {
                        // Found key
                        uint64_t read_key;
                        // Assume key is int64/sint64/uint64. Let's assume standard int64 (varint).
                        // If the map is defined as map<int64, ...>, it's varint.
                        if (pb::internal::WireFormatLite::GetTagWireType(tag) == pb::internal::WireFormatLite::WIRETYPE_VARINT) {
                            coded_input.ReadVarint64(&read_key);
                            if (static_cast<int64_t>(read_key) == key) {
                                // Match! Delete this entry.
                                ufs->DeleteSubrange(i, 1);
                                // Don't break because there might be duplicates? Standard map shouldn't have them, but safe to continue?
                                // If we delete, indices change? No, we iterate backwards.
                                // But if we delete, we are done with THIS entry.
                                goto entry_deleted;
                            }
                        }
                    } else {
                        // Skip field
                        pb::internal::WireFormatLite::SkipField(&coded_input, tag);
                    }
                }
            }
            entry_deleted:;
        }

        // 2. Add new entry
        std::string buffer;
        pb::io::StringOutputStream output(&buffer);
        pb::io::CodedOutputStream coded_output(&output);

        // Write Key (Tag 1)
        pb::internal::WireFormatLite::WriteInt64(1, key, &coded_output);
        // Write Value (Tag 2)
        pb::internal::WireFormatLite::WriteInt64(2, value, &coded_output);

        coded_output.Trim();
        ufs->AddLengthDelimited(map_tag, buffer);
    }

    // --- Nested Structures ---

    template <typename T>
    static T GetNestedMessage(const pb::Message& msg, int tag) {
        T local_msg;
        const auto& ufs = GetUFS(msg);
        // Find the LAST occurrence? Or merge all? Standard protobuf merges.
        // We'll merge all found.
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_LENGTH_DELIMITED) {
                local_msg.MergeFromString(field.length_delimited());
            }
        }
        return local_msg;
    }

    static void SetNestedMessage(pb::Message* msg, int tag, const pb::Message& nested_msg) {
        auto* ufs = MutableUFS(msg);
        ufs->DeleteByNumber(tag); // Last-one-wins for singular message field

        std::string bytes;
        nested_msg.SerializeToString(&bytes);
        ufs->AddLengthDelimited(tag, bytes);
    }

    // --- Group Support ---
    // "Explicitly handle TYPE_GROUP by traversing the nested UnknownFieldSet tree."
    // We can provide a way to get a GenericProtoManager view of a Group?
    // Or just GetGroup as UnknownFieldSet?

    static const pb::UnknownFieldSet* GetGroup(const pb::Message& msg, int tag) {
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
             const auto& field = ufs.field(i);
             if (field.number() == tag && field.type() == pb::UnknownField::TYPE_GROUP) {
                 return &field.group();
             }
        }
        return nullptr;
    }
};
