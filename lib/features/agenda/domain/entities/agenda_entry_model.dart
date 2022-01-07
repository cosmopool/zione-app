import 'package:zione/features/agenda/domain/entities/entry_model.dart';

class AgendaEntry extends Entry {
  int id = -1;
  String clientName = "not initialized variable";
  String clientPhone = "not initialized variable";
  String clientAddress = "not initialized variable";
  String serviceType = "not initialized variable";
  String description = "not initialized variable";
  String date = "not initialized variable";
  String time = "not initialized variable";
  String duration = "not initialized variable";
  int ticketId = -1;
  bool appointmentIsFinished = false;

  AgendaEntry(Map<String, dynamic> response) {
    id = response['id'] as int;
    clientName = response['clientName'] as String;
    clientPhone = response['clientPhone'] as String;
    clientAddress = response['clientAddress'] as String;
    serviceType = response['serviceType'] as String;
    description = response['description'] as String;
    date = response['date'] as String;
    time = response['time'] as String;
    duration = response['duration'] as String;
    ticketId = response['ticketId'] as int;
    appointmentIsFinished = response['isFinished'] as bool;

    time = time.substring(0, 5);
    duration = duration.substring(0, 5);
  }

  @override
  Map toMap() {
    Map map = {};

    if (map['id'] != null) map['id'] = id;
    if (map['ticketId'] != null) map['ticketId'] = ticketId;
    map['clientName'] = clientName;
    map['clientPhone'] = clientPhone;
    map['clientAddress'] = clientAddress;
    map['serviceType'] = serviceType;
    map['description'] = description;
    map['date'] = date;
    map['time'] = time;
    map['duration'] = duration;

    return map;
  }

  @override
  void edit(Map map) {
    map['clientName'] = clientName;
    map['clientPhone'] = clientPhone;
    map['clientAddress'] = clientAddress;
    map['serviceType'] = serviceType;
    map['description'] = description;
    map['date'] = date;
    map['time'] = time;
    map['duration'] = duration;
    map['ticketId'] = ticketId;
    map['appointmentIsFinished'] = appointmentIsFinished;
  }
}
