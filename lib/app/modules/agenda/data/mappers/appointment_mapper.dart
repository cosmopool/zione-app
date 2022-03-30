import 'dart:convert';

import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';

class AppointmentMapper {
  static AppointmentEntity fromJson(String str) => fromMap(json.decode(str));

  static List toMapList(List<AppointmentEntity> list) =>
      list.map((entity) => toMap(entity)).toList();

  static List<AppointmentEntity> fromMapList(List list) =>
      list.map((json) => fromMap(json)).toList();

  static String toJson(AppointmentEntity entity) => json.encode(toMap(entity));

  static AppointmentEntity fromMap(Map json) {
    /* final date = json["date"] as String; */
    /* final time = json["time"] as String; */

    return AppointmentEntity(
      id: json["id"] ?? -1,
      /* dateTime: DateTime.parse("$date $time"), */
      date: json["date"] as String,
      time: json["time"] as String,
      duration: json["duration"] as String,
      ticketId: json["ticketId"] ?? -1,
      isFinished: json["isFinished"] ?? false,
    );
  }

  static Map toMap(AppointmentEntity entity) {
    /* final dt = entity.dateTime; */
    return {
      "id": entity.id,
      /* "date": "${dt.year}/${dt.month}/${dt.day}", */
      /* "time": "${dt.hour}:${dt.minute}", */
      "date": entity.date,
      "time": entity.time,
      "duration": entity.duration,
      "ticketId": entity.ticketId,
      "isFinished": entity.isFinished,
    };
  }
}
