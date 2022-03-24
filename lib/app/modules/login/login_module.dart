import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/login/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/login/data/datasources/remote/api_datasource.dart';
import 'package:zione/app/modules/login/data/repositories/authentication_repository.dart';
import 'package:zione/app/modules/login/domain/usecases/login_usecase.dart';
import 'package:zione/app/modules/login/ui/controller/login_store.dart';
import 'package:zione/app/modules/login/ui/pages/login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => Hive.box("settings")),
    Bind.lazySingleton((i) => HiveAuthDatasource(i())),
    Bind.lazySingleton((i) => Settings(i())),
    Bind.lazySingleton((i) => ApiAuthDatasource(settings: i())),
    Bind.lazySingleton((i) => AuthenticationRepository(i(), i())),
    Bind.lazySingleton((i) => LoginUsecase(i())),
    Bind.lazySingleton((i) => LoginStore(i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage()),
      ];
}
