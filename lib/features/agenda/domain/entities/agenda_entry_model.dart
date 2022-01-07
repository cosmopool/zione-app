part 'entry_model.dart';

class AgendaEntry extends Entry {
  int? id;
  late String clientName;
  late String clientPhone;
  late String clientAddress;
  late String serviceType;
  late String description;
  late String date;
  late String time;
  late String duration;
  late int appointmentId;
  late int ticketId;
  late bool appointmentIsFinished;

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
    Map agendaEntry = {};

    if (agendaEntry['id'] != null) {
      agendaEntry['id'] = id;
    }
    if (agendaEntry['ticketId'] != null) {
      agendaEntry['ticketId'] = ticketId;
    }
    agendaEntry['clientName'] = clientName;
    agendaEntry['clientPhone'] = clientPhone;
    agendaEntry['clientAddress'] = clientAddress;
    agendaEntry['serviceType'] = serviceType;
    agendaEntry['description'] = description;
    agendaEntry['date'] = date;
    agendaEntry['time'] = time;
    agendaEntry['duration'] = duration;

    return agendaEntry;
  }
}
