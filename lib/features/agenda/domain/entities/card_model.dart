import 'package:zione_app/features/agenda/models/ticket_model.dart';

abstract class Card {}

class TicketCard extends Card {
  late Ticket ticket;

 // int get id => fields.id;
  // String get clientName => fields.clientName;
  // String get clientPhone => fields.clientPhone;
  // String get clientAddress => fields.clientAddress;
  // String get serviceType => fields.serviceType;
  // String get description => fields.description;
  // bool get isFinished => fields.isFinished;

  // set clientName(String val) => fields.clientName = val;

  TicketCard.fromMap(Map map){
    ticket = Ticket.fromMap(map);
  }
}

class AgendaEntryCard {}
class AppointmentCard {}
