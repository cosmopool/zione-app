import 'package:equatable/equatable.dart';
import 'package:zione/app/modules/core/extensions/datetime_extension.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

class AppointmentEntity extends Equatable {
  late final int _id;
  late DateTime dateTime;
  late String _duration;
  late int ticketId;
  late bool isFinished;

  AppointmentEntity({
    id = -1,
    required date,
    required time,
    required duration,
    dateTime,
    this.ticketId = -1,
    this.isFinished = false,
  })  : _id = id,
        _duration = duration,
        dateTime = dateTime ?? DateTime.parse("$date $time");

  /// Returns a string with appointment [date]
  ///
  /// ```dart
  /// final ap = AppointmentEntity(date: "2021-01-01");
  /// print(ap.date) // "2021-01-01"
  /// ```
  String get date => dateTime.dateOnly;

  set date(String newDate) => dateTime = DateTime.parse("$newDate $time");

  String get duration => _duration.substring(0, 5);

  set duration(String str) => _duration = str;

  Endpoint get endpoint => Endpoint.appointments;

  String get finalTime =>
      _addDuration().toString().split(" ")[1].substring(0, 5);

  /// Returns true if appointment [date] has already passed.
  bool get hasPassed => dateTime.isBefore(DateTime.now());

  int get id => _id;

  String get time => dateTime.timeOnly;

  set time(String newTime) => dateTime = DateTime.parse("$date $newTime");

  /// A way to edit a appointment with a given map
  ///
  /// Only valid dictionary keys is used to edit
  /// the entry. All other keys is discarted.
  void edit(Map map) {
    (map['date'] != null) ? date = map['date'] : null;
    (map['time'] != null) ? time = map['time'] : null;
    (map['duration'] != null) ? duration = map['duration'] : null;
    (map['ticketId'] != null) ? ticketId = map['ticketId'] : null;
    (map['isFinished'] != null) ? isFinished = map['isFinished'] : null;
  }

  /// Returns a [Map] of the entity.
  Map<String, dynamic> toMap() => {
        "id": _id,
        "date": date,
        "time": time,
        "duration": duration,
        "ticketId": ticketId,
        "isFinished": isFinished,
      };

  /// Returns DateTime obj with [time] + [duration] as time
  ///
  /// Returns DateTime object with date as [date]
  /// and time as [time] + [duration]
  ///
  /// eg:.
  /// ```dart
  /// [time] = "10:00"
  /// [duration] = "01:00"
  /// [date] = "2022-01-01"
  /// _addDuration().toString() // "2022-01-01 11:00:00"
  /// ```
  DateTime _addDuration() {
    final durationSplit = duration.split(":");
    return dateTime.add(
      Duration(
        hours: int.parse(durationSplit[0]),
        minutes: int.parse(durationSplit[1]),
      ),
    );
  }

  @override
  List<Object?> get props =>
      [_id, dateTime, date, time, duration, ticketId, isFinished];
}
