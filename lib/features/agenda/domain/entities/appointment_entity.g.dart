// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentEntityAdapter extends TypeAdapter<AppointmentEntity> {
  @override
  final int typeId = 1;

  @override
  AppointmentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentEntity(
      id: fields[1] as dynamic,
      date: fields[2] as String,
      time: fields[3] as String,
      duration: fields[4] as String,
      ticketId: fields[5] as int,
      isFinished: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.ticketId)
      ..writeByte(6)
      ..write(obj.isFinished)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.endpoint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
