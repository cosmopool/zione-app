import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zione/core/widgets/bottom_navigation_bar_widget.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/features/agenda/ui/widgets/bottom_modal/bottom_modal.dart';
import 'package:zione/features/agenda/ui/widgets/entry_feed/appointments_feed.dart';
import 'package:zione/features/agenda/ui/widgets/entry_feed/ticket_feed.dart';
import 'package:zione/features/agenda/ui/widgets/entry_form/add_entry.dart';
import 'package:zione/features/agenda/ui/widgets/entry_form/add_ticket.dart';
import 'package:zione/utils/enums.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<FeedProvider>().refresh(Endpoint.tickets);
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarCustom(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showBottomAutoSizeModal(
          context,
          (_tabController.index == 0) ? EntryForm() : TicketForm(),
        ),
        label: (_tabController.index == 0)
            ? const Text('Agendamento')
            : const Text('Chamado'),
        icon: const Icon(FontAwesomeIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('Agenda'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Agendamentos",
              icon: Icon(FontAwesomeIcons.calendarCheck),
            ),
            Tab(
              text: "Chamados",
              icon: Icon(FontAwesomeIcons.tools),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(
            child: AppointmentsFeed(),
          ),
          Center(
            child: TicketsFeed(),
          ),
        ],
      ),
    );
  }
}
