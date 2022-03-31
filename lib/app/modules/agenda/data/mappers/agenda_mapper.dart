import 'dart:convert';

import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';

class AgendaMapper {
  static AgendaEntity fromJson(String str) => fromMap(json.decode(str));

  static List toMapList(List<AgendaEntity> list) =>
      list.map((entity) => toMap(entity)).toList();

  static List<AgendaEntity> fromMapList(List list) =>
      list.map((json) => fromMap(json)).toList();

  static String toJson(AgendaEntity entity) => json.encode(toMap(entity));

  static AppointmentEntity toAppointment(AgendaEntity entity) =>
      AppointmentEntity(
        date: entity.date,
        time: entity.time,
        duration: entity.duration,
      );

  static TicketEntity toTicket(AgendaEntity entity) => TicketEntity(
        clientName: entity.clientName,
        clientPhone: entity.clientPhone,
        clientAddress: entity.clientAddress,
        serviceType: entity.serviceType,
        description: entity.description,
      );

  static AgendaEntity fromMap(Map json) => AgendaEntity(
        id: json["id"] ?? -1,
        date: json["date"] as String,
        time: json["time"] as String,
        duration: json["duration"] as String,
        ticketId: json["ticketId"] ?? -1,
        isFinished: json["isFinished"] ?? false,
        clientName: json['clientName'] as String,
        clientPhone: json['clientPhone'] as String,
        clientAddress: json['clientAddress'] as String,
        serviceType: json['serviceType'] as String,
        description: json['description'] as String,
        ticketIsFinished: json["ticketIsFinished"] ?? false,
      );

  static Map toMap(AgendaEntity entity) => {
        "id": entity.id,
        "date": entity.date,
        "time": entity.time,
        "duration": entity.duration,
        "ticketId": entity.ticketId,
        "isFinished": entity.isFinished,
        'clientName': entity.clientName,
        'clientPhone': entity.clientPhone,
        'clientAddress': entity.clientAddress,
        'serviceType': entity.serviceType,
        'description': entity.description,
        "ticketIsFinished": entity.ticketIsFinished,
      };
}
