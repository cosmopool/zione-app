import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

int returnIdFromEntry(entry) {
  final id = entry?.id;
  if (id != null) {
    return id;
  } else {
    return 0;
  }
}

class CardMenu extends StatelessWidget {
  final String entryTitle;
  final Ticket? ticket;
  final AgendaEntry? appointment;
  // final Appointment? appointment;

  const CardMenu(this.entryTitle, this.ticket, this.appointment);

  @override
  Widget build(BuildContext context) {
    late final Entry entry;

    final ticketId = returnIdFromEntry(ticket);
    if (ticketId > 0) {
      entry = Entry.ticket;
    }
    final appointmentId = returnIdFromEntry(appointment);
    if (appointmentId > 0) {
      entry = Entry.appointment;
    }

    Future<void> _showMyDialog(Action action) async {
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

    return Column(
      children: [
        ListTile(
          leading: const Icon(FontAwesomeIcons.trash),
          title: Text('Deletar $entryTitle'),
          onTap: () {
            _showMyDialog(Action.delete);
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.calendarCheck),
          title: Text("Finalizar $entryTitle"),
          onTap: () {
            _showMyDialog(Action.close);
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.edit),
          title: Text("Editar $entryTitle"),
          onTap: () {
            // TODO: implement edit form
            print('edit this entry');
            Navigator.pop(context);
          },
        ),
        Visibility(
            visible: (entry == Entry.ticket),
            child: ListTile(
              leading: const Icon(FontAwesomeIcons.calendarAlt),
              title: const Text("Marcar Agendamento"),
              onTap: () {
                // TODO: implement book appointment
                print('book appointment');
                Navigator.pop(context);
              },
            ))
      ],
    );
  }
}
