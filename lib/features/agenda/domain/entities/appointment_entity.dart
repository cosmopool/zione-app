import 'package:hive_flutter/hive_flutter.dart';
import 'package:zione/core/utils/enums.dart';

part 'appointment_entity.g.dart';

@HiveType(typeId: 1)
class AppointmentEntity {
  late int _id = -1;
  @HiveField(2)
  late String date;
  @HiveField(3)
  late String time;
  @HiveField(4)
  late String duration;
  @HiveField(5)
  late int ticketId = -1;
  @HiveField(6)
  late bool isFinished = false;

  AppointmentEntity({
    id = -1,
    required this.date,
    required this.time,
    required this.duration,
    this.ticketId = -1,
    this.isFinished = false,
  }) : _id = id;

  AppointmentEntity.fromMap(Map response) {
    if (response['id'] != null) _id = response['id'];
    date = response['date'] as String;
    time = response['time'] as String;
    duration = response['duration'] as String;
    ticketId = response['ticketId'] as int;
    if (response['isFinished'] != null) isFinished = response['isFinished'];

    time = time.substring(0, 5);
    duration = duration.substring(0, 5);
  }

  @HiveField(1)
  int get id => _id;

  @HiveField(7)
  Endpoint get endpoint => Endpoint.appointments;

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

  void edit(Map map) {
    (map['date'] != null) ? date = map['date'] : null;
    (map['time'] != null) ? time = map['time'] : null;
    (map['duration'] != null) ? duration = map['duration'] : null;
    (map['ticketId'] != null) ? ticketId = map['ticketId'] : null;
    (map['isFinished'] != null) ? isFinished = map['isFinished'] : null;
  }
}
