import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/utils/enums.dart';

class AgendaEntryEntity extends EntryEntity {
  int _id = -1;
  late String clientName;
  late String clientPhone;
  late String clientAddress;
  late String serviceType;
  late String description;
  late String date;
  late String time;
  late String duration;
  int ticketId = -1;
  bool isFinished = false;
  bool ticketIsFinished = false;

  AgendaEntryEntity({
    required this.clientName,
    required this.clientPhone,
    required this.clientAddress,
    required this.serviceType,
    required this.description,
    required this.date,
    required this.time,
    required this.duration,
    ticketId,
    isFinished,
    ticketIsFinished,
  });

  AgendaEntryEntity.fromMap(Map map) {
    _id = map['id'] ?? _id;
    clientName = map['clientName'] as String;
    clientPhone = map['clientPhone'] as String;
    clientAddress = map['clientAddress'] as String;
    serviceType = map['serviceType'] as String;
    description = map['description'] as String;
    date = map['date'] as String;
    time = map['time'] as String;
    duration = map['duration'] as String;
    ticketId = map['ticketId'] ?? ticketId;
    isFinished = map['isFinished'] ?? isFinished;
    ticketIsFinished = map['ticketIsFinished'] ?? ticketIsFinished;

    time = time.substring(0, 5);
    duration = duration.substring(0, 5);
  }

  @override
  int get id => _id;

  @override
  Entry get type => Entry.agenda;

  @override
  Endpoint get endpoint => Endpoint.agenda;

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
    /* if (_id < 0) _id = map['id']; */
    /* if (ticketId < 0) ticketId = map['ticketId']; */
    clientName = map['clientName'] ?? clientName;
    clientPhone = map['clientPhone'] ?? clientPhone;
    clientAddress = map['clientAddress'] ?? clientAddress;
    serviceType = map['serviceType'] ?? serviceType;
    description = map['description'] ?? description;
    date = map['date'] ?? date;
    time = map['time'] ?? time;
    duration = map['duration'] ?? duration;
    ticketId = map['ticketId'] ?? ticketId;
    isFinished = map['isFinished'] ?? isFinished;
    ticketIsFinished = map['ticketIsFinished'] ?? ticketIsFinished;
    /* (map['clientName'] != null) ? clientName = map['clientName'] : null; */
    /* (map['clientPhone'] != null) ? clientPhone = map['clientPhone'] : null; */
    /* (map['clientAddress'] != null) ? clientAddress = map['clientAddress'] : null; */
    /* (map['serviceType'] != null) ? serviceType = map['serviceType'] : null; */
    /* (map['description'] != null) ? description = map['description'] : null; */
    /* (map['date'] != null) ? date = map['date'] : null; */
    /* (map['time'] != null) ? time = map['time'] : null; */
    /* (map['duration'] != null) ? duration = map['duration'] : null; */
    /* (map['ticketId'] != null) ? ticketId = map['ticketId'] : null; */
    /* (map['isFinished'] != null) ? isFinished = map['isFinished'] : null; */
    /* (map['ticketIsFinished'] != null) ? ticketIsFinished = map['ticketIsFinished'] : null; */
  }
}
