import 'dart:convert';

import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';

class TicketMapper {
  static TicketEntity fromJson(String str) => fromMap(json.decode(str));

  static List toMapList(List<TicketEntity> list) =>
      list.map((entity) => toMap(entity)).toList();

  static List<TicketEntity> fromMapList(List list) =>
      list.map((json) => fromMap(json)).toList();

  static String toJson(TicketEntity entity) => json.encode(toMap(entity));

  static TicketEntity fromMap(Map json) => TicketEntity(
        id: json["id"] ?? -1,
        clientName: json['clientName'] as String,
        clientPhone: json['clientPhone'] as String,
        clientAddress: json['clientAddress'] as String,
        serviceType: json['serviceType'] as String,
        description: json['description'] as String,
        isFinished: json['isFinished'] as bool,
      );

  static Map toMap(TicketEntity entity) => {
        'id': entity.id,
        'clientName': entity.clientName,
        'clientPhone': entity.clientPhone,
        'clientAddress': entity.clientAddress,
        'serviceType': entity.serviceType,
        'description': entity.description,
        'isFinished': entity.isFinished,
      };
}
