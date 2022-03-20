import 'package:hive_flutter/hive_flutter.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/utils/enums.dart';

part 'ticket_entity.g.dart';

@HiveType(typeId: 3)
class TicketEntity implements EntryEntity {
  @HiveField(1)
  int _id = -1;
  @HiveField(2)
  late String clientName;
  @HiveField(3)
  late String clientPhone;
  @HiveField(4)
  late String clientAddress;
  @HiveField(5)
  late String serviceType;
  @HiveField(6)
  late String description;
  @HiveField(7)
  bool isFinished = false;

  TicketEntity(
      {required this.clientName,
      required this.clientPhone,
      required this.clientAddress,
      required this.serviceType,
      required this.description});

  TicketEntity.fromMap(Map map) {
   if (map['id'] != null) _id = map['id'];
   clientName = map['clientName'];
   clientPhone = map['clientPhone'];
   clientAddress = map['clientAddress'];
   serviceType = map['serviceType'];
   description = map['description'];
   if (map['isFinished'] != null) isFinished = map['isFinished'];
  }

  @override
  int get id => _id;

  @override
  Endpoint get endpoint => Endpoint.tickets;

  @override
  Entry get type => Entry.ticket;

  set setProperty(String prop) => (prop == "Gustavo") ? clientName = prop : null;

  @override
  Map toMap() {
    Map ticketToMap = {};

    if (_id > 0) ticketToMap['id'] = _id;
    ticketToMap['clientName'] = clientName;
    ticketToMap['clientPhone'] = clientPhone;
    ticketToMap['clientAddress'] = clientAddress;
    ticketToMap['serviceType'] = serviceType;
    ticketToMap['description'] = description;
    ticketToMap['isFinished'] = isFinished;

    return ticketToMap;
  }

  @override
  void edit(Map map) {
    (map['clientName'] != null) ? clientName = map['clientName'] : null;
    (map['clientPhone'] != null) ? clientPhone = map['clientPhone'] : null;
    (map['clientAddress'] != null)
        ? clientAddress = map['clientAddress']
        : null;
    (map['serviceType'] != null) ? serviceType = map['serviceType'] : null;
    (map['description'] != null) ? description = map['description'] : null;
  }
}
