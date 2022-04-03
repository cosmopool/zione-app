import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/app/modules/agenda/ui/widgets/bottom_modal/bottom_modal.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_feed/ticket_feed.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/add_ticket.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('Chamado'),
            icon: const Icon(FontAwesomeIcons.plus),
            onPressed: () => showBottomAutoSizeModal(context, const AddTicketForm()),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: const TicketsFeed(),
      ),
    );
  }
}
