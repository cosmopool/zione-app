import 'package:zione/features/agenda/domain/entities/entry_entity.dart';

class AgendaEntryEntity extends EntryEntity {
  int _id = -1;
  String clientName = "not initialized variable";
  String clientPhone = "not initialized variable";
  String clientAddress = "not initialized variable";
  String serviceType = "not initialized variable";
  String description = "not initialized variable";
  String date = "not initialized variable";
  String time = "not initialized variable";
  String duration = "not initialized variable";
  int ticketId = -1;
  bool isFinished = false;
  bool ticketIsFinished = false;

  AgendaEntryEntity(Map<String, dynamic> response) {
    _id = response['id'] as int;
    clientName = response['clientName'] as String;
    clientPhone = response['clientPhone'] as String;
    clientAddress = response['clientAddress'] as String;
    serviceType = response['serviceType'] as String;
    description = response['description'] as String;
    date = response['date'] as String;
    time = response['time'] as String;
    duration = response['duration'] as String;
    ticketId = response['ticketId'] as int;
    isFinished = response['isFinished'] as bool;
    ticketIsFinished = response['ticketIsFinished'] as bool;

    time = time.substring(0, 5);
    duration = duration.substring(0, 5);
  }

  @override
  int get id => _id;

  @override
  Map toMap() {
    Map map = {};

    if (_id > 0) map['id'] = _id;
    if (ticketId > 0) map['ticketId'] = ticketId;
    map['clientName'] = clientName;
    map['clientPhone'] = clientPhone;
    map['clientAddress'] = clientAddress;
    map['serviceType'] = serviceType;
    map['description'] = description;
    map['date'] = date;
    map['time'] = time;
    map['duration'] = duration;
    map['isFinished'] = isFinished;
    map['ticketIsFinished'] = ticketIsFinished;

    return map;
  }

  @override
  void edit(Map map) {
    (map['clientName'] != null) ? clientName = map['clientName'] : null;
    (map['clientPhone'] != null) ? clientPhone = map['clientPhone'] : null;
    (map['clientAddress'] != null) ? clientAddress = map['clientAddress'] : null;
    (map['serviceType'] != null) ? serviceType = map['serviceType'] : null;
    (map['description'] != null) ? description = map['description'] : null;
    (map['date'] != null) ? date = map['date'] : null;
    (map['time'] != null) ? time = map['time'] : null;
    (map['duration'] != null) ? duration = map['duration'] : null;
    (map['ticketId'] != null) ? ticketId = map['ticketId'] : null;
    (map['isFinished'] != null) ? isFinished = map['isFinished'] : null;
    (map['ticketIsFinished'] != null) ? ticketIsFinished = map['ticketIsFinished'] : null;
  }
}