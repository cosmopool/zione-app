import 'package:zione/app/modules/core/utils/enums.dart';

class TicketEntity {
  int _id = -1;
  late String clientName;
  late String clientPhone;
  late String clientAddress;
  late String serviceType;
  late String description;
  bool isFinished = false;

  TicketEntity({
      id = -1,
      required this.clientName,
      required this.clientPhone,
      required this.clientAddress,
      required this.serviceType,
      required this.description,
    this.isFinished = false,
  }) : _id = id;

  TicketEntity.fromMap(Map map) {
   if (map['id'] != null) _id = map['id'];
   clientName = map['clientName'];
   clientPhone = map['clientPhone'];
   clientAddress = map['clientAddress'];
   serviceType = map['serviceType'];
   description = map['description'];
   if (map['isFinished'] != null) isFinished = map['isFinished'];
  }

  int get id => _id;

  Endpoint get endpoint => Endpoint.tickets;

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
