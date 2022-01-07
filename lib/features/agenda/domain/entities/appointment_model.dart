import 'dart:convert';

import 'package:zione_app/core/constants.dart';
import 'package:zione_app/repositories/entry_repository.dart';
import 'package:zione_app/features/agenda/models/entry_model.dart';
import 'package:zione_app/features/agenda/models/ticket_model.dart';
import 'package:zione_app/services/cache_service.dart' as cache;

class Appointment extends Entry {
  int _id = -1;
  String date = "not initialized variable";
  String time = "not initialized variable";
  String duration = "not initialized variable";
  int ticketId = -1;
  bool isFinished = false;

  Ticket? _ticket;

  final Endpoint _endpoint = Endpoint.appointments;
  final EntryRepository _requests = EntryRepository();

  Appointment({
    required this.date,
    required this.time,
    required this.duration,
    required this.ticketId,
  });

  // Appointment.fromResponse(Response response) {
  //   final Map json = jsonDecode(response.message);

  //   _id = json['id'] as int;
  //   date = json['date'] as String;
  //   time = json['time'] as String;
  //   duration = json['duration'] as String;
  //   ticketId = json['ticketId'] as int;
  // }

  Appointment.fromMap(Map map) {
    _id = map['id'];
    date = map['date'] as String;
    time = map['time'] as String;
    duration = map['duration'] as String;
    ticketId = map['ticketId'] as int;
  }

  int get getId {
    return _id;
  }

  String get clientName {
    if (_ticket == null) _setTicket();
    return _ticket!.clientName;
  }

  String get clientAddress {
    if (_ticket == null) _setTicket();
    return _ticket!.clientAddress;
  }

  String get clientPhone {
    if (_ticket == null) _setTicket();
    return _ticket!.clientPhone;
  }

  String get serviceType {
    if (_ticket == null) _setTicket();
    return _ticket!.serviceType;
  }

  String get description {
    if (_ticket == null) _setTicket();
    return _ticket!.description;
  }

  void _loopList(list) {
    // look for ticket with ticketId from this appointment
    list.forEach((ticket) {
      if (ticket.id == ticketId) _ticket = ticket;
    });
  }

  void _setTicket() async {
    // look for ticketId in cached listOfTickets
    _loopList(cache.listOfTickets);

    // if not found
    if (_ticket == null) {
      // fetch fresh list of tickets from rest api
      await _fetchTickets();
      // and try looking again
      _loopList(cache.listOfTickets);
    }
  }

  Future<List> _fetchTickets() async {
    /// fetch fresh list of tickets from rest api
    late Response response;
    late List<Map> json;
    final EntryRepository entryRepository = EntryRepository();
    List<Ticket> _listOfTickets = [];
    response = await entryRepository.fetchContent(_endpoint);

    if (response.status == Status.success) {
      json = jsonDecode(response.message);
      json.forEach((ticketMap) {
        _listOfTickets.add(Ticket.fromMap(ticketMap));
      });
      cache.listOfTickets = _listOfTickets;
    }
    return cache.listOfTickets;
  }

  Map withTicketToMap() {
    Map appointmentToMap = {};

    if (_id > 0) appointmentToMap['id'] = _id;
    appointmentToMap['date'] = date;
    appointmentToMap['time'] = time;
    appointmentToMap['duration'] = duration;
    appointmentToMap['ticketId'] = ticketId;
    appointmentToMap['isFinished'] = isFinished;
    if (_ticket != null) {
      appointmentToMap['clientName'] = _ticket!.clientName;
      appointmentToMap['clientPhone'] = _ticket!.clientPhone;
      appointmentToMap['clientAddress'] = _ticket!.clientAddress;
      appointmentToMap['serviceType'] = _ticket!.serviceType;
      appointmentToMap['description'] = _ticket!.description;
    }

    return appointmentToMap;
  }

  @override
  Map toMap() {
    Map appointmentToMap = {};

    if (_id > 0) appointmentToMap['id'] = _id;
    appointmentToMap['date'] = date;
    appointmentToMap['time'] = time;
    appointmentToMap['duration'] = duration;
    appointmentToMap['ticketId'] = ticketId;
    appointmentToMap['isFinished'] = isFinished;

    return appointmentoMap;
  }

  @override
  Future<Response> post() async {
    final result = await _requests.postContent(_endpoint, this);

    return result;
  }

  @override
  Future<Response> update() async {
    final result = await _requests.updateContent(_endpoint, this);

    return result;
  }

  @override
  Future<Response> delete() async {
    final result = await _requests.deleteContent(_endpoint, this);

    return result;
  }

  @override
  Future<Response> close() async {
    final result = await _requests.closeContent(_endpoint, this);

    return result;
  }
}
T
