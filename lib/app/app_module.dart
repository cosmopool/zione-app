import 'package:flutter_modular/flutter_modular.dart';
import 'package:zione/app/modules/agenda/agenda_module.dart';
import 'package:zione/app/modules/login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: AgendaModule()),
        ModuleRoute('/login', module: LoginModule()),
      ];
}
