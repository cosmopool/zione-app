import 'package:flutter/material.dart';
import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/utils/enums.dart';
// Future<void>
// late final Entry entry;

// final ticketId = returnIdFromEntry(ticket);
// if (ticketId > 0) {
//   entry = Entry.ticket;
// }
// final appointmentId = returnIdFromEntry(appointment);
// if (appointmentId > 0) {
//   entry = Entry.appointment;
// }

class DialogCardMenu {
  Future<void> deleteTicketDialog(TicketEntity entry) {}
  Future<void> deleteAppointmentDialog(AgendaEntryEntity entry) {}

  Future<void> showMyDialog(String msg, String title, context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Não'),
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                request(endpoint, {'id': id});
                // TODO: snackbar with response status
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> showMyDialog(Action action) async {
  late int id;
  late String msg;
  late String endpoint;
  late String entryType;
  late String title;
  var request;

  if (entry == Entry.ticket) {
    entryType = "chamado";
    endpoint = "tickets";
    id = ticketId;
  } else {
    entryType = "agendamento";
    endpoint = "appointments";
    id = appointmentId;
  }

  if (action == Action.delete) {
    title = "Deletar $entryType";
    msg = "Tem certeza que deseja deletar esse $entryType?";
    request = req.deleteContent;
  } else if (action == Action.close) {
    title = "Finalizar $entryType";
    msg = "Tem certeza que deseja finalizar esse $entryType?";
    request = req.closeContent;
  }
}

// class DialogCardMenu extends StatelessWidget {
//   const DialogCardMenu({Key? key}) : super(key: key);

//   Future<void> _showMyDialog(EntryAction action) async {
//     late String msg;
//     const Endpoint _endpoint = Endpoint.tickets;
//     late String title;

//     if (action == EntryAction.delete) {
//       title = "Deletar Chamado";
//       msg = "Tem certeza que deseja deletar esse chamado?";
//       // request = req.deleteContent;
//     } else if (action == EntryAction.close) {
//       title = "Finalizar Chamado";
//       msg = "Tem certeza que deseja finalizar esse chamado?";
//       // request = req.closeContent;
//     }

//     @override
//     Widget build(BuildContext context) {
//       return Center();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text(msg),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'Cancel'),
//               child: const Text('Não'),
//             ),
//             TextButton(
//               child: const Text('Sim'),
//               onPressed: () {
//                 // request(endpoint, {'id': id});
//                 // TODO: snackbar with response status
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
