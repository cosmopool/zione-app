import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/app/modules/agenda/ui/widgets/bottom_modal/bottom_modal.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_feed/appointment_feed.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_form/add_entry.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Agendamento'),
          icon: const Icon(FontAwesomeIcons.plus),
          onPressed: () => showBottomAutoSizeModal(context, const EntryForm()),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: const AppointmentsFeed(),
      ),
    );
  }
}
