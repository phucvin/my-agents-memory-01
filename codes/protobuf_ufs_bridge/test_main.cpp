#include <gtest/gtest.h>
#include "generic_proto_manager.h"
#include <google/protobuf/message.h>
#include <google/protobuf/unknown_field_set.h>
#include <google/protobuf/empty.pb.h>

using namespace google::protobuf;

class GenericProtoManagerTest : public ::testing::Test {
protected:
    Empty msg;
};

TEST_F(GenericProtoManagerTest, SInt64_Access) {
    int tag = 100;
    int64_t value = -123456789012345;

    // Caller A writes
    GenericProtoManager::SetSInt64(&msg, tag, value);

    // Caller B reads
    int64_t read_value = GenericProtoManager::GetSInt64(msg, tag);
    EXPECT_EQ(value, read_value);

    // Verify data integrity in UFS
    const UnknownFieldSet& ufs = GenericProtoManager::GetUFS(msg);
    EXPECT_EQ(ufs.field_count(), 1);
    EXPECT_EQ(ufs.field(0).number(), tag);
    EXPECT_EQ(ufs.field(0).type(), UnknownField::TYPE_VARINT);
}

TEST_F(GenericProtoManagerTest, Oneof_Safety) {
    int tagA = 10;
    int tagB = 11;

    // Set field A
    GenericProtoManager::SetSInt64(&msg, tagA, 100);
    EXPECT_EQ(GenericProtoManager::GetSInt64(msg, tagA), 100);

    // Set field B, declaring A as sibling
    std::vector<int> siblings = {tagA};
    GenericProtoManager::SetFieldWithOneofSafety(&msg, tagB, (int64_t)200, siblings,
        [](Message* m, int t, int64_t v) {
            GenericProtoManager::SetSInt64(m, t, v);
        }
    );

    // Verify A is gone, B is present
    EXPECT_EQ(GenericProtoManager::GetSInt64(msg, tagA), 0); // Default 0
    EXPECT_EQ(GenericProtoManager::GetSInt64(msg, tagB), 200);

    const UnknownFieldSet& ufs = GenericProtoManager::GetUFS(msg);
    EXPECT_EQ(ufs.field_count(), 1);
    EXPECT_EQ(ufs.field(0).number(), tagB);
}

TEST_F(GenericProtoManagerTest, Map_Update) {
    int map_tag = 50;

    // Add entry: Key=1, Value=100
    GenericProtoManager::SetMapEntry(&msg, map_tag, 1, 100);

    // Add entry: Key=2, Value=200
    GenericProtoManager::SetMapEntry(&msg, map_tag, 2, 200);

    // Verify we have 2 entries
    const UnknownFieldSet& ufs = GenericProtoManager::GetUFS(msg);
    EXPECT_EQ(ufs.field_count(), 2);

    // Update Key=1 -> Value=150
    // This should detect Key=1 and replace it
    GenericProtoManager::SetMapEntry(&msg, map_tag, 1, 150);

    // Verify we still have 2 entries (old Key=1 deleted, new Key=1 added)
    EXPECT_EQ(ufs.field_count(), 2);

    // Manually verify contents
    bool found_key_1 = false;
    bool found_key_2 = false;

    for (int i = 0; i < ufs.field_count(); ++i) {
        if (ufs.field(i).number() != map_tag) continue;

        std::string bytes = ufs.field(i).length_delimited();
        io::ArrayInputStream input(bytes.data(), bytes.size());
        io::CodedInputStream coded_input(&input);

        uint32_t tag;
        int64_t key = 0;
        int64_t value = 0;

        while ((tag = coded_input.ReadTag()) != 0) {
            int field_num = internal::WireFormatLite::GetTagFieldNumber(tag);
            if (field_num == 1) {
                coded_input.ReadVarint64((uint64_t*)&key);
            } else if (field_num == 2) {
                coded_input.ReadVarint64((uint64_t*)&value);
            } else {
                internal::WireFormatLite::SkipField(&coded_input, tag);
            }
        }

        if (key == 1) {
            EXPECT_EQ(value, 150);
            found_key_1 = true;
        } else if (key == 2) {
            EXPECT_EQ(value, 200);
            found_key_2 = true;
        }
    }

    EXPECT_TRUE(found_key_1);
    EXPECT_TRUE(found_key_2);
}

TEST_F(GenericProtoManagerTest, PackedVarints) {
    int tag = 200;
    std::vector<uint64_t> values = {1, 2, 300, 4000, 50000};

    GenericProtoManager::SetPackedVarints(&msg, tag, values);

    std::vector<uint64_t> read_values = GenericProtoManager::GetPackedVarints(msg, tag);
    EXPECT_EQ(values, read_values);
}

TEST_F(GenericProtoManagerTest, NestedMessage) {
    int tag = 300;
    Empty nested;
    // Put some data into 'nested' via the manager
    GenericProtoManager::SetSInt64(&nested, 1, 42);

    // Serialize and store into main msg
    GenericProtoManager::SetNestedMessage(&msg, tag, nested);

    // Retrieve
    Empty read_nested = GenericProtoManager::GetNestedMessage<Empty>(msg, tag);
    EXPECT_EQ(GenericProtoManager::GetSInt64(read_nested, 1), 42);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
