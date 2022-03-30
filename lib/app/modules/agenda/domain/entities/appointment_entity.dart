import 'package:equatable/equatable.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

class AppointmentEntity extends Equatable {
  late int _id;
  late String date;
  late String time;
  late String duration;
  late int ticketId;
  late bool isFinished;

  AppointmentEntity({
    id = -1,
    required this.date,
    required this.time,
    required this.duration,
    this.ticketId = -1,
    this.isFinished = false,
  }) : _id = id;

  int get id => _id;

  Endpoint get endpoint => Endpoint.appointments;

  /// Returns a [Map] of the entity.
  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "time": time,
        "duration": duration,
        "ticketId": ticketId,
        "isFinished": isFinished,
      };


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

  @override
  List<Object?> get props => [_id, date, time, duration, ticketId, isFinished];
}
