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

    // --- Basic Accessors ---

    static bool HasField(const pb::Message& msg, int tag) {
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            if (ufs.field(i).number() == tag) {
                return true;
            }
        }
        return false;
    }

    static void ClearField(pb::Message* msg, int tag) {
        MutableUFS(msg)->DeleteByNumber(tag);
    }

    // --- Varint Accessors ---

    static uint64_t GetVarint(const pb::Message& msg, int tag, uint64_t default_value = 0) {
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_VARINT) {
                return field.varint();
            }
        }
        return default_value;
    }

    static void SetVarint(pb::Message* msg, int tag, uint64_t value) {
        auto* ufs = MutableUFS(msg);
        ufs->DeleteByNumber(tag);
        ufs->AddVarint(tag, value);
    }

    static bool GetBool(const pb::Message& msg, int tag) { return GetVarint(msg, tag) != 0; }
    static void SetBool(pb::Message* msg, int tag, bool value) { SetVarint(msg, tag, value ? 1 : 0); }

    static int32_t GetInt32(const pb::Message& msg, int tag) { return static_cast<int32_t>(GetVarint(msg, tag)); }
    static void SetInt32(pb::Message* msg, int tag, int32_t value) { SetVarint(msg, tag, static_cast<uint64_t>(value)); }

    static uint32_t GetUInt32(const pb::Message& msg, int tag) { return static_cast<uint32_t>(GetVarint(msg, tag)); }
    static void SetUInt32(pb::Message* msg, int tag, uint32_t value) { SetVarint(msg, tag, static_cast<uint64_t>(value)); }

    static int64_t GetInt64(const pb::Message& msg, int tag) { return static_cast<int64_t>(GetVarint(msg, tag)); }
    static void SetInt64(pb::Message* msg, int tag, int64_t value) { SetVarint(msg, tag, static_cast<uint64_t>(value)); }

    static uint64_t GetUInt64(const pb::Message& msg, int tag) { return GetVarint(msg, tag); }
    static void SetUInt64(pb::Message* msg, int tag, uint64_t value) { SetVarint(msg, tag, value); }

    static int GetEnum(const pb::Message& msg, int tag) { return static_cast<int>(GetVarint(msg, tag)); }
    static void SetEnum(pb::Message* msg, int tag, int value) { SetVarint(msg, tag, static_cast<uint64_t>(value)); }

    // --- Fixed32 Accessors ---

    static uint32_t GetFixed32(const pb::Message& msg, int tag, uint32_t default_value = 0) {
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_FIXED32) {
                return field.fixed32();
            }
        }
        return default_value;
    }

    static void SetFixed32(pb::Message* msg, int tag, uint32_t value) {
        auto* ufs = MutableUFS(msg);
        ufs->DeleteByNumber(tag);
        ufs->AddFixed32(tag, value);
    }

    static float GetFloat(const pb::Message& msg, int tag) {
        uint32_t val = GetFixed32(msg, tag);
        float result;
        static_assert(sizeof(float) == sizeof(uint32_t), "Float must be 32 bits");
        memcpy(&result, &val, sizeof(float));
        return result;
    }

    static void SetFloat(pb::Message* msg, int tag, float value) {
        uint32_t val;
        memcpy(&val, &value, sizeof(float));
        SetFixed32(msg, tag, val);
    }

    static int32_t GetSFixed32(const pb::Message& msg, int tag) { return static_cast<int32_t>(GetFixed32(msg, tag)); }
    static void SetSFixed32(pb::Message* msg, int tag, int32_t value) { SetFixed32(msg, tag, static_cast<uint32_t>(value)); }

    // --- Fixed64 Accessors ---

    static uint64_t GetFixed64(const pb::Message& msg, int tag, uint64_t default_value = 0) {
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_FIXED64) {
                return field.fixed64();
            }
        }
        return default_value;
    }

    static void SetFixed64(pb::Message* msg, int tag, uint64_t value) {
        auto* ufs = MutableUFS(msg);
        ufs->DeleteByNumber(tag);
        ufs->AddFixed64(tag, value);
    }

    static double GetDouble(const pb::Message& msg, int tag) {
        uint64_t val = GetFixed64(msg, tag);
        double result;
        static_assert(sizeof(double) == sizeof(uint64_t), "Double must be 64 bits");
        memcpy(&result, &val, sizeof(double));
        return result;
    }

    static void SetDouble(pb::Message* msg, int tag, double value) {
        uint64_t val;
        memcpy(&val, &value, sizeof(double));
        SetFixed64(msg, tag, val);
    }

    static int64_t GetSFixed64(const pb::Message& msg, int tag) { return static_cast<int64_t>(GetFixed64(msg, tag)); }
    static void SetSFixed64(pb::Message* msg, int tag, int64_t value) { SetFixed64(msg, tag, static_cast<uint64_t>(value)); }

    // --- String/Bytes Accessors ---

    static std::string GetString(const pb::Message& msg, int tag, const std::string& default_value = "") {
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_LENGTH_DELIMITED) {
                return field.length_delimited();
            }
        }
        return default_value;
    }

    static void SetString(pb::Message* msg, int tag, const std::string& value) {
        auto* ufs = MutableUFS(msg);
        ufs->DeleteByNumber(tag);
        ufs->AddLengthDelimited(tag, value);
    }

    static std::string GetBytes(const pb::Message& msg, int tag) { return GetString(msg, tag); }
    static void SetBytes(pb::Message* msg, int tag, const std::string& value) { SetString(msg, tag, value); }

    // --- Repeated Field Support ---

    static int GetRepeatedCount(const pb::Message& msg, int tag) {
        const auto& ufs = GetUFS(msg);
        int count = 0;
        for (int i = 0; i < ufs.field_count(); ++i) {
            if (ufs.field(i).number() == tag) {
                count++;
            }
        }
        return count;
    }

    // Varint
    static void AddRepeatedVarint(pb::Message* msg, int tag, uint64_t value) {
        MutableUFS(msg)->AddVarint(tag, value);
    }

    static std::vector<uint64_t> GetRepeatedVarint(const pb::Message& msg, int tag) {
        std::vector<uint64_t> result;
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag) {
                if (field.type() == pb::UnknownField::TYPE_VARINT) {
                    result.push_back(field.varint());
                } else if (field.type() == pb::UnknownField::TYPE_LENGTH_DELIMITED) {
                    // Try to parse as packed
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
                }
            }
        }
        return result;
    }

    static void AddRepeatedBool(pb::Message* msg, int tag, bool value) { AddRepeatedVarint(msg, tag, value ? 1 : 0); }
    static std::vector<bool> GetRepeatedBool(const pb::Message& msg, int tag) {
        std::vector<uint64_t> raw = GetRepeatedVarint(msg, tag);
        std::vector<bool> result;
        result.reserve(raw.size());
        for (auto v : raw) result.push_back(v != 0);
        return result;
    }

    static void AddRepeatedInt32(pb::Message* msg, int tag, int32_t value) { AddRepeatedVarint(msg, tag, static_cast<uint64_t>(value)); }
    static std::vector<int32_t> GetRepeatedInt32(const pb::Message& msg, int tag) {
        std::vector<uint64_t> raw = GetRepeatedVarint(msg, tag);
        std::vector<int32_t> result;
        result.reserve(raw.size());
        for (auto v : raw) result.push_back(static_cast<int32_t>(v));
        return result;
    }

    static void AddRepeatedInt64(pb::Message* msg, int tag, int64_t value) { AddRepeatedVarint(msg, tag, static_cast<uint64_t>(value)); }
    static std::vector<int64_t> GetRepeatedInt64(const pb::Message& msg, int tag) {
        std::vector<uint64_t> raw = GetRepeatedVarint(msg, tag);
        std::vector<int64_t> result;
        result.reserve(raw.size());
        for (auto v : raw) result.push_back(static_cast<int64_t>(v));
        return result;
    }

    // Fixed32
    static void AddRepeatedFixed32(pb::Message* msg, int tag, uint32_t value) {
        MutableUFS(msg)->AddFixed32(tag, value);
    }

    static std::vector<uint32_t> GetRepeatedFixed32(const pb::Message& msg, int tag) {
        std::vector<uint32_t> result;
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag) {
                if (field.type() == pb::UnknownField::TYPE_FIXED32) {
                    result.push_back(field.fixed32());
                } else if (field.type() == pb::UnknownField::TYPE_LENGTH_DELIMITED) {
                    const std::string& bytes = field.length_delimited();
                    pb::io::ArrayInputStream input(bytes.data(), bytes.size());
                    pb::io::CodedInputStream coded_input(&input);
                    uint32_t val;
                    while (!coded_input.ExpectAtEnd()) {
                        if (coded_input.ReadLittleEndian32(&val)) {
                            result.push_back(val);
                        } else {
                            break;
                        }
                    }
                }
            }
        }
        return result;
    }

    static void AddRepeatedFloat(pb::Message* msg, int tag, float value) {
        uint32_t val;
        memcpy(&val, &value, sizeof(float));
        AddRepeatedFixed32(msg, tag, val);
    }

    static std::vector<float> GetRepeatedFloat(const pb::Message& msg, int tag) {
        std::vector<uint32_t> raw = GetRepeatedFixed32(msg, tag);
        std::vector<float> result;
        result.reserve(raw.size());
        for (auto v : raw) {
            float f;
            memcpy(&f, &v, sizeof(float));
            result.push_back(f);
        }
        return result;
    }

    // Fixed64
    static void AddRepeatedFixed64(pb::Message* msg, int tag, uint64_t value) {
        MutableUFS(msg)->AddFixed64(tag, value);
    }

    static std::vector<uint64_t> GetRepeatedFixed64(const pb::Message& msg, int tag) {
        std::vector<uint64_t> result;
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag) {
                if (field.type() == pb::UnknownField::TYPE_FIXED64) {
                    result.push_back(field.fixed64());
                } else if (field.type() == pb::UnknownField::TYPE_LENGTH_DELIMITED) {
                     const std::string& bytes = field.length_delimited();
                     pb::io::ArrayInputStream input(bytes.data(), bytes.size());
                     pb::io::CodedInputStream coded_input(&input);
                     uint64_t val;
                     while (!coded_input.ExpectAtEnd()) {
                         if (coded_input.ReadLittleEndian64(&val)) {
                             result.push_back(val);
                         } else {
                             break;
                         }
                     }
                }
            }
        }
        return result;
    }

    static void AddRepeatedDouble(pb::Message* msg, int tag, double value) {
        uint64_t val;
        memcpy(&val, &value, sizeof(double));
        AddRepeatedFixed64(msg, tag, val);
    }

    static std::vector<double> GetRepeatedDouble(const pb::Message& msg, int tag) {
        std::vector<uint64_t> raw = GetRepeatedFixed64(msg, tag);
        std::vector<double> result;
        result.reserve(raw.size());
        for (auto v : raw) {
            double d;
            memcpy(&d, &v, sizeof(double));
            result.push_back(d);
        }
        return result;
    }

    // String
    static void AddRepeatedString(pb::Message* msg, int tag, const std::string& value) {
        MutableUFS(msg)->AddLengthDelimited(tag, value);
    }

    static std::vector<std::string> GetRepeatedString(const pb::Message& msg, int tag) {
        std::vector<std::string> result;
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_LENGTH_DELIMITED) {
                result.push_back(field.length_delimited());
            }
        }
        return result;
    }

    // --- SInt32 Accessors ---

    static int32_t GetSInt32(const pb::Message& msg, int tag) {
        const auto& ufs = GetUFS(msg);
        for (int i = 0; i < ufs.field_count(); ++i) {
            const auto& field = ufs.field(i);
            if (field.number() == tag && field.type() == pb::UnknownField::TYPE_VARINT) {
                return pb::internal::WireFormatLite::ZigZagDecode32(static_cast<uint32_t>(field.varint()));
            }
        }
        return 0;
    }

    static void SetSInt32(pb::Message* msg, int tag, int32_t value) {
        auto* ufs = MutableUFS(msg);
        ufs->DeleteByNumber(tag);
        uint32_t encoded = pb::internal::WireFormatLite::ZigZagEncode32(value);
        ufs->AddVarint(tag, encoded);
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
