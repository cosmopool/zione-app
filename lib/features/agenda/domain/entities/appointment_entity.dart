import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/utils/enums.dart';

class AppointmentEntity extends EntryEntity {
  int _id = -1;
  String date = "not initialized variable";
  String time = "not initialized variable";
  String duration = "not initialized variable";
  int ticketId = -1;
  bool isFinished = false;
  final Entry _type = Entry.appointment;

  AppointmentEntity(Map<String, dynamic> response) {
    _id = response['id'] as int;
    date = response['date'] as String;
    time = response['time'] as String;
    duration = response['duration'] as String;
    ticketId = response['ticketId'] as int;
    isFinished = response['isFinished'] as bool;

    time = time.substring(0, 5);
    duration = duration.substring(0, 5);
  }

  @override
  int get id => _id;

  @override
  Entry get type => _type;

  @override
  Map toMap() {
    Map map = {};

    if (_id > 0) map['id'] = _id;
    if (ticketId > 0) map['ticketId'] = ticketId;
    map['date'] = date;
    map['time'] = time;
    map['duration'] = duration;
    map['ticketId'] = ticketId;
    map['isFinished'] = isFinished;

    return map;
  }

  @override
  void edit(Map map) {
    (map['date'] != null) ? date = map['date'] : null;
    (map['time'] != null) ? time = map['time'] : null;
    (map['duration'] != null) ? duration = map['duration'] : null;
    (map['ticketId'] != null) ? ticketId = map['ticketId'] : null;
    (map['isFinished'] != null) ? isFinished = map['isFinished'] : null;
  }
}
