import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/features/agenda/ui/screens/agenda_page.dart';

import 'core/dependency_injection.dart';
import 'utils/enums.dart';
import 'features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';

Future<void> main() async {
  Inject.init();
  // TODO: try to use static method call to setup hive
  await Hive.initFlutter();
  Hive.registerAdapter(ResponseStatusAdapter());
  Hive.registerAdapter(ResponseAdapter());
  await Hive.openBox('contentCacheBox');
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
