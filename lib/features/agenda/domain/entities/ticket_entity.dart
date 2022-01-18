import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/utils/enums.dart';

class TicketEntity extends EntryEntity {
  final Entry _type = Entry.ticket;
  int _id = -1;
  String clientName = "not initialized variable";
  String clientPhone = "not initialized variable";
  String clientAddress = "not initialized variable";
  String serviceType = "not initialized variable";
  String description = "not initialized variable";
  bool isFinished = false;

  // TicketEntity(
  //     {required this.clientName,
  //     required this.clientPhone,
  //     required this.clientAddress,
  //     required this.serviceType,
  //     required this.description});

  TicketEntity(Map map) {
    _id = map['id'] as int;
    clientName = map['clientName'] as String;
    clientPhone = map['clientPhone'] as String;
    clientAddress = map['clientAddress'] as String;
    serviceType = map['serviceType'] as String;
    description = map['description'] as String;
    isFinished = map['isFinished'] as bool;
  }

  @override
  int get id => _id;

  @override
  Entry get type => _type;

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
    (map['clientAddress'] != null) ? clientAddress = map['clientAddress'] : null;
    (map['serviceType'] != null) ? serviceType = map['serviceType'] : null;
    (map['description'] != null) ? description = map['description'] : null;
  }
}
