import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/utils/enums.dart';

class CardMenu extends StatelessWidget {
  final String entryTitle;
  final TicketEntity ticket;

  const CardMenu({Key? key, required this.entryTitle, required this.ticket})
      : super(key: key);

  String _getTitle(EntryAction action) {
    String res = "";

    if (action == EntryAction.delete) {
      res = "Deletar chamado";
    } else if (action == EntryAction.close) {
      res = "Fechar chamado";
    } else if (action == EntryAction.edit) {
      res = "Editar chamado";
    }

    return "Tem certeza que deseja $res esse chamado?";
  }

  String _getMessage(EntryAction action) {
    String res = "";

    if (action == EntryAction.delete) {
      res = "deletar";
    } else if (action == EntryAction.close) {
      res = "fechar";
    } else if (action == EntryAction.edit) {
      res = "editar";
    }

    return "Tem certeza que deseja $res esse chamado?";
  }

    // var req;

    // if (action == EntryAction.delete) {
    //   res = "deletar";
    //   req = context.read<FeedProvider>().delete;
    // } else if (action == EntryAction.close) {
    //   res = "fechar";
    //   req = context.read<FeedProvider>().close;
    // } else if (action == EntryAction.edit) {
    //   res = "editar";
    //   req = context.read<FeedProvider>().edit;
    // }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(EntryAction action) async {

      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(_getTitle(action)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(_getMessage(action)),
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
                  // request(endpoint, {'id': id});
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
          title: Text('Deletar Chamado'),
          onTap: () {
            _showMyDialog(EntryAction.delete);
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.calendarCheck),
          title: Text("Finalizar Chamado"),
          onTap: () {
            _showMyDialog(EntryAction.close);
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.edit),
          title: Text("Editar Chamado"),
          onTap: () {
            // TODO: implement edit form
            print('edit this entry');
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.calendarAlt),
          title: const Text("Marcar Agendamento"),
          onTap: () {
            // TODO: implement book appointment
            print('book appointment');
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
