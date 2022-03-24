// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketEntityAdapter extends TypeAdapter<TicketEntity> {
  @override
  final int typeId = 2;

  @override
  TicketEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketEntity(
      id: fields[1] as dynamic,
      clientName: fields[2] as String,
      clientPhone: fields[3] as String,
      clientAddress: fields[4] as String,
      serviceType: fields[5] as String,
      description: fields[6] as String,
      isFinished: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TicketEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(2)
      ..write(obj.clientName)
      ..writeByte(3)
      ..write(obj.clientPhone)
      ..writeByte(4)
      ..write(obj.clientAddress)
      ..writeByte(5)
      ..write(obj.serviceType)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.isFinished)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.endpoint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
