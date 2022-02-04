import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarCustomState createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  // TODO: write provider to selectedScreenIndex

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey[600],
      currentIndex: _selectedScreenIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.calendarAlt),
          label: 'Agenda',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.tasks),
          label: 'Tarefas',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.tools),
          label: 'Tickets',
        ),
      ],
      onTap: _selectScreen,
    );
  }
}
