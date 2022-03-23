// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseAdapter extends TypeAdapter<Response> {
  @override
  final int typeId = 3;

  @override
  Response read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Response(
      status: fields[0] as Status,
      result: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Response obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.result)
      ..writeByte(2)
      ..write(obj.isSuccessful)
      ..writeByte(3)
      ..write(obj.isServerOffline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
