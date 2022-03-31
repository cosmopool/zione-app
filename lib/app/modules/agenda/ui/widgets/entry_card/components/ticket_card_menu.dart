import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/bottom_modal/bottom_modal.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/add_appointment.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/edit_ticket.dart';
import 'package:zione/app/modules/core/utils/string_extensions.dart';

class TicketCardMenu extends StatelessWidget {
  final TicketEntity ticket;
  final store = Modular.get<TicketStore>();

  TicketCardMenu({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(String action, dynamic callback) async {
      final title = "${action.toCapitalized()} Chamado";
      final msg =
          "Tem certeza que deseja ${action.toLowerCase()} esse chamado?";

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
          title: const Text('Deletar Chamado'),
          onTap: () {
            _showMyDialog("Deletar", () => store.delete(ticket));
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.calendarCheck),
          title: const Text("Finalizar Chamado"),
          onTap: () {
            _showMyDialog("Finalizar", () => store.close(ticket));
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.edit),
          title: const Text("Editar Chamado"),
          onTap: () {
            showBottomAutoSizeModal(
              context,
              EditTicketForm(ticket: ticket),
            );
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.calendarAlt),
          title: const Text("Marcar Agendamento"),
          onTap: () {
            showBottomAutoSizeModal(
              context,
              AddAppointmentForm(ticket: ticket),
            );
          },
        )
      ],
    );
  }
}
