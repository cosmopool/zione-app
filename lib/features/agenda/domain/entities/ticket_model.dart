import 'package:zione/features/agenda/domain/entities/entry_model.dart';

class Ticket extends Entry {
  int _id = -1;
  String clientName = "not initialized variable";
  String clientPhone = "not initialized variable";
  String clientAddress = "not initialized variable";
  String serviceType = "not initialized variable";
  String description = "not initialized variable";
  bool isFinished = false;

  Ticket(
      {required this.clientName,
      required this.clientPhone,
      required this.clientAddress,
      required this.serviceType,
      required this.description});

  Ticket.fromMap(Map map) {
    _id = map['id'] as int;
    clientName = map['clientName'] as String;
    clientPhone = map['clientPhone'] as String;
    clientAddress = map['clientAddress'] as String;
    serviceType = map['serviceType'] as String;
    description = map['description'] as String;
    isFinished = map['isFinished'] as bool;
  }

  int get id {
    return _id;
  }

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
    map['clientName'] = clientName;
    map['clientPhone'] = clientPhone;
    map['clientAddress'] = clientAddress;
    map['serviceType'] = serviceType;
    map['description'] = description;
    map['isFinished'] = isFinished;
  }
}
