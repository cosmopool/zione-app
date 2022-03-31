import 'package:equatable/equatable.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

class AgendaEntity extends Equatable{
  int _id = -1;
  late String date;
  late String time;
  late String duration;
  late int ticketId;
  bool isFinished = false;
  late String clientName;
  late String clientPhone;
  late String clientAddress;
  late String serviceType;
  late String description;
  bool ticketIsFinished = false;

  AgendaEntity({
    id = -1,
    required this.date,
    required this.time,
    required this.duration,
    this.ticketId = -1,
    this.isFinished = false,
    required this.clientName,
    required this.clientPhone,
    required this.clientAddress,
    required this.serviceType,
    required this.description,
    this.ticketIsFinished = false,
  }) : _id = id;

  /// Returns a [Map] of the entity.
  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "time": time,
        "duration": duration,
        "ticketId": ticketId,
        "isFinished": isFinished,
        "clientName": clientName,
        "clientPhone": clientPhone,
        "clientAddress": clientAddress,
        "serviceType": serviceType,
        "description": description,
        "ticketIsFinished": ticketIsFinished,
      };

  int get id => _id;

  Endpoint get endpoint => Endpoint.agenda;

  @override
  List<Object?> get props => [_id, date, time, duration, ticketId, isFinished, clientName, clientPhone, clientAddress, serviceType, description, ticketIsFinished];
}
