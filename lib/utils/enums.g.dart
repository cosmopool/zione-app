// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseStatusAdapter extends TypeAdapter<ResponseStatus> {
  @override
  final int typeId = 2;

  @override
  ResponseStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ResponseStatus.success;
      case 1:
        return ResponseStatus.err;
      default:
        return ResponseStatus.success;
    }
  }

  @override
  void write(BinaryWriter writer, ResponseStatus obj) {
    switch (obj) {
      case ResponseStatus.success:
        writer.writeByte(0);
        break;
      case ResponseStatus.err:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
