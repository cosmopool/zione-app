import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/utils/enums.dart';

class CardMenu extends StatelessWidget {
  final EntryEntity _entry;
  final Endpoint _endpoint;
  const CardMenu(this._entry, this._endpoint);

  @override
  Widget build(BuildContext context) {
    final String entryTitle = (_entry.type == Entry.ticket) ? "Chamado" : "Agendamento";
    // final String ticketMsg = "Tem certeza de que deseja "

    Future<void> _showMyDialog(EntryAction action) async {
      late String msg;
      late String title;
      late var cardAction;
      final String entryTitleLowerCase = entryTitle.toLowerCase();

      if (action == EntryAction.delete) {
        title = "Deletar $entryTitle";
        msg = "Tem certeza que deseja deletar esse $entryTitleLowerCase?";
        cardAction = () => context.read<FeedProvider>().delete(_entry, _endpoint);
      } else if (action == EntryAction.close) {
        title = "Finalizar $entryTitle";
        msg = "Tem certeza que deseja finalizar esse $entryTitleLowerCase?";
        cardAction = () => context.read<FeedProvider>().close(_entry, _endpoint);
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
                child: const Text('Não'),
                onPressed: () => Navigator.pop(context, 'Cancel'),
              ),
              TextButton(
                child: const Text('Sim'),
                onPressed: () {
                  cardAction();
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
            _showMyDialog(EntryAction.delete);
          },
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.calendarCheck),
          title: Text("Finalizar $entryTitle"),
          onTap: () {
            _showMyDialog(EntryAction.close);
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
            visible: (_entry.type == Entry.ticket),
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
