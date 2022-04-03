import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:zione/app/app_module.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("settings");
  await Hive.openBox("agenda");
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Delforte app',
      /* theme: ThemeData.light().copyWith(useMaterial3: true), */
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepBlue,
        scaffoldBackground: Colors.grey[100],
      ),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.deepBlue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
