import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/app/modules/agenda/ui/stores/feed_store.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final store = Modular.get<FeedStore>();

  @override
  initState() {
    store.navigateTo(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: RouterOutlet(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: store.screenIndex,
        onDestinationSelected: (index) {
          store.navigateTo(index);
        },
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
