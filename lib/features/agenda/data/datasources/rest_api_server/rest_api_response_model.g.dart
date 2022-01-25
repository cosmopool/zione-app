// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_api_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseAdapter extends TypeAdapter<Response> {
  @override
  final int typeId = 1;

  @override
  Response read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    late final String _status;
    late dynamic _result;
    _status = (fields[0] == ResponseStatus.success) ? 'Success' : 'Error';
    _result = fields[1];
    final Map json = {'Status': _status, 'Result': _result};
    return Response(json);
  }

  @override
  void write(BinaryWriter writer, Response obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._status)
      ..writeByte(1)
      ..write(obj._result)
      ..writeByte(2)
      ..write(obj._offline);
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