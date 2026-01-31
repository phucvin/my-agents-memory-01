# Protobuf UnknownFieldSet Bridge

This project demonstrates a `GenericProtoManager` in C++ that interacts with a schema-less `google::protobuf::Message` strictly through its `UnknownFieldSet`. It ensures type safety and semantic integrity (like Oneof mutual exclusivity and Map key uniqueness) without using Protobuf's schema-based reflection for field access.

## Features

- **SInt64 Support**: Manual ZigZag encoding/decoding.
- **Packed Varints**: Manual parsing/encoding of length-delimited byte arrays.
- **Oneof Safety**: Automatic deletion of sibling fields when setting a oneof field.
- **Map Management**: Unique key enforcement by scanning and removing old entries in the UnknownFieldSet.
- **Nested Messages**: Serialization and deserialization of nested structures.
- **Group Support**: Traversal of `TYPE_GROUP` fields.

## Building and Testing

Prerequisites: `protobuf` and `gtest`.

To build and run the tests:

```bash
make
./test_runner
```

## Example Usage

See `test_main.cpp` for detailed usage examples.
