import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entry_entity.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/entities/entry_entity.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/ui/providers/feed_provider.dart';
import 'package:zione/app/modules/agenda/ui/widgets/bottom_modal/bottom_modal.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/add_appointment.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/edit_appointment.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/edit_ticket.dart';
import 'package:zione/app/modules/core/utils/enums.dart';
import 'package:zione/app/modules/core/utils/string_extensions.dart';

class CardMenu extends StatelessWidget {
  final EntryEntity _entry;
  final Endpoint _endpoint;
  const CardMenu(this._entry, this._endpoint);

  @override
  Widget build(BuildContext context) {
    final String entryTitle =
        (_entry.type == Entry.ticket) ? "Chamado" : "Agendamento";

    Future<void> _showMyDialog(String action, dynamic callback) async {
      final title = "${action.toCapitalized()} $entryTitle";
      final msg =
          "Tem certeza que deseja ${action.toLowerCase()} esse ${entryTitle.toLowerCase()}?";

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
                child: const Text('Não'),
                onPressed: () => Navigator.pop(context, 'Cancelar'),
              ),
              TextButton(
                child: const Text('Sim'),
                onPressed: () {
                  callback();
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
            _showMyDialog("Deletar",
                () => context.read<FeedProvider>().delete(_entry, _endpoint));
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.calendarCheck),
          title: Text("Finalizar $entryTitle"),
          onTap: () {
            _showMyDialog("finalizar",
                () => context.read<FeedProvider>().close(_entry, _endpoint));
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.edit),
          title: Text("Editar $entryTitle"),
          onTap: () {
            if (_entry.type == Entry.appointment) {
              showBottomAutoSizeModal(
                context,
                EditAppointmentForm(appointment: (_entry as AppointmentEntity)),
              );
            } else if (_entry.type == Entry.ticket) {
              showBottomAutoSizeModal(
                context,
                EditTicketForm(ticket: (_entry as TicketEntity)),
              );
            } else {
                /* final map = _entry.toMap(); */
                final entry = _entry as AgendaEntryEntity;
                final map = {'id': entry.id, 'date': entry.date, 'time': entry.time, 'duration': entry.duration, 'ticketId': entry.ticketId, 'isFinished': entry.isFinished};
                /* print("------------------------------------- $map"); */
                final ap = AppointmentEntity(map);
              showBottomAutoSizeModal(
                context,
                EditAppointmentForm(appointment: ap),
              );
            }
          },
        ),
        Visibility(
            visible: (_entry.type == Entry.ticket),
            child: ListTile(
              leading: const Icon(FontAwesomeIcons.calendarAlt),
              title: const Text("Marcar Agendamento"),
              onTap: () {
                showBottomAutoSizeModal(
                  context,
                  AddAppointmentForm(ticket: (_entry as TicketEntity)),
                );
              },
            ))
      ],
    );
  }
}
