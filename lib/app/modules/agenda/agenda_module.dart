import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/api_datasource.dart';
import 'package:zione/app/modules/agenda/data/repositories/ticket_repository.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_tickets.dart';
import 'package:zione/app/modules/agenda/ui/screens/agenda_page.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';

class AgendaModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => Settings(Hive.box("settings"))),
    Bind.lazySingleton((i) => HiveDatasouce(Hive.box("agenda"))),
    Bind.lazySingleton((i) => ApiServerDataSource(settings: i())),
    Bind.lazySingleton((i) => Settings(Hive.box("settings"))),
    Bind.lazySingleton((i) => TicketRepository(i(), i(), i())),
    Bind.lazySingleton((i) => FetchTicketsUsecase(i())),
    Bind.lazySingleton((i) => TicketStore(i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AgendaPage()),
      ];
}
