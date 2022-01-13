import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/features/agenda/ui/screens/tickets_page.dart';
import 'package:zione/features/agenda/ui/widgets/entry_feed/appointments_feed.dart';
import 'package:zione/utils/enums.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  void initState() {
    super.initState();
    context.read<FeedProvider>().refresh(Endpoint.tickets);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: "Agendamentos",
            ),
            Tab(
              text: "Chamados",
            ),
          ]),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: AppointmentsFeed(),
            ),
            Center(
              child: TicketsFeed(),
              // child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
