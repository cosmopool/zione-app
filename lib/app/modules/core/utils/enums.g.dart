// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 2;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.success;
      case 1:
        return Status.err;
      default:
        return Status.success;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.success:
        writer.writeByte(0);
        break;
      case Status.err:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
