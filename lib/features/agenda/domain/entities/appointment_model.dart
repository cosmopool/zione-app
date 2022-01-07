import 'package:zione/features/agenda/domain/entities/entry_model.dart';

class Appointment extends Entry {
  int id = -1;
  String date = "not initialized variable";
  String time = "not initialized variable";
  String duration = "not initialized variable";
  int ticketId = -1;
  bool isFinished = false;

  Appointment(Map<String, dynamic> response) {
    id = response['id'] as int;
    date = response['date'] as String;
    time = response['time'] as String;
    duration = response['duration'] as String;
    ticketId = response['ticketId'] as int;
    isFinished = response['isFinished'] as bool;

    time = time.substring(0, 5);
    duration = duration.substring(0, 5);
  }

  @override
  Map toMap() {
    Map map = {};

    if (map['id'] != null) map['id'] = id;
    if (map['ticketId'] != null) map['ticketId'] = ticketId;
    map['date'] = date;
    map['time'] = time;
    map['duration'] = duration;
    map['ticketId'] = ticketId;
    map['isFinished'] = isFinished;

    return map;
  }

  @override
  void edit(Map map) {
    map['date'] = date;
    map['time'] = time;
    map['duration'] = duration;
    map['ticketId'] = ticketId;
    map['isFinished'] = isFinished;
  }
}
