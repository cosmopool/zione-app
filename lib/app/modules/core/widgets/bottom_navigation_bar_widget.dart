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

  // TODO: write provider for selectedScreenIndex

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedScreenIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.calendarAlt),
          label: 'Agenda',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.cog),
          label: 'Configurações',
        ),
      ],
      onTap: _selectScreen,
    );
  }
}
