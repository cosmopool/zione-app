import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/features/agenda/ui/screens/agenda_page.dart';

import 'core/dependency_injection.dart';

Future<void> main() async {
  await Inject.init();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetIt.instance<FeedProvider>()),
      ],
      child: MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'GoRouter Example',
      ),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AgendaPage(),
      ),
      // GoRoute(
      //   path: '/main',
      //   builder: (context, state) => MainPage(),
      // ),
      // GoRoute(
      //   path: '/agenda',
      //   builder: (context, state) => AgendaPage(),
      // ),
      GoRoute(
        path: '/add',
        builder: (context, state) => const AgendaPage(),
      ),
      GoRoute(
        path: '/tickets',
        builder: (context, state) => const AgendaPage(),
      ),
    ],
  );
}
