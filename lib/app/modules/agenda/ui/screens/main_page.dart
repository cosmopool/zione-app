import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/app/modules/agenda/ui/screens/agenda_page.dart';
import 'package:zione/app/modules/agenda/ui/screens/ticket_page.dart';

class MainPage extends StatefulWidget {
  int screenIndex = 0;
  MainPage({Key? key, this.screenIndex = 0}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final screens = [const AgendaPage(), const TicketsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens[widget.screenIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.screenIndex,
        onDestinationSelected: (index) => setState(() => widget.screenIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.calendarCheck),
            label: "Agenda",
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.screwdriverWrench),
            label: "Chamados",
          )
        ],
      ),
    );
  }
}
