import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/app/modules/core/widgets/bottom_navigation_bar_widget.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_feed/ticket_feed.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  /* final controller = Modular.get<FeedStore>(); */

  @override
  void initState() {
    super.initState();
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
      /* floatingActionButton: FloatingActionButton.extended( */
        /* onPressed: () => showBottomAutoSizeModal( */
        /*   context, */
        /*   (_tabController.index == 0) ? EntryForm() : AddTicketForm(), */
        /* ), */
      /*   label: (_tabController.index == 0) */
      /*       ? const Text('Agendamento') */
      /*       : const Text('Chamado'), */
      /*   icon: const Icon(FontAwesomeIcons.plus), */
      /* ), */
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
            child: TicketsFeed(),
          ),
          Center(
            child: TicketsFeed(),
          ),
        ],
      ),
    );
  }
}
