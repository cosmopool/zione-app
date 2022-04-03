import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:zione/app/modules/agenda/data/repositories/agenda_repository.dart';
import 'package:zione/app/modules/agenda/data/repositories/appointment_repository.dart';
import 'package:zione/app/modules/agenda/domain/usecases/close_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/close_ticket_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/delete_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/delete_ticket_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/edit_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/edit_ticket_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_appointments.dart';
import 'package:zione/app/modules/agenda/domain/usecases/insert_agenda_entry_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/insert_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/insert_ticket_usecase.dart';
import 'package:zione/app/modules/agenda/ui/screens/main_page.dart';
import 'package:zione/app/modules/agenda/ui/stores/agenda_store.dart';
import 'package:zione/app/modules/agenda/ui/stores/appointment_store.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/api_datasource.dart';
import 'package:zione/app/modules/agenda/data/repositories/ticket_repository.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_tickets_usecase.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';

class AgendaModule extends Module {
  @override
  List<Bind> get binds => [
        // data/datasources
        Bind.lazySingleton((i) => Settings(Hive.box("settings"))),
        Bind.lazySingleton((i) => HiveDatasouce(Hive.box("agenda"))),
        Bind.lazySingleton((i) => ApiServerDataSource(settings: i())),
        // data/repositories
        Bind.lazySingleton((i) => TicketRepository(i(), i(), i())),
        Bind.lazySingleton((i) => AppointmentRepository(i(), i(), i())),
        Bind.lazySingleton((i) => AgendaRepository(i(), i())),
        // domain/usecases/agenda
        Bind.lazySingleton((i) => InsertAgendaUsecase(i())),
        // domain/usecases/tickets
        Bind.lazySingleton((i) => FetchTicketsUsecase(i())),
        Bind.lazySingleton((i) => CloseTicketUsecase(i())),
        Bind.lazySingleton((i) => DeleteTicketUsecase(i())),
        Bind.lazySingleton((i) => EditTicketUsecase(i())),
        Bind.lazySingleton((i) => InsertTicketUsecase(i())),
        // domain/usecases/appointments
        Bind.lazySingleton((i) => FetchAppointmentsUsecase(i())),
        Bind.lazySingleton((i) => CloseAppointmentUsecase(i())),
        Bind.lazySingleton((i) => DeleteAppointmentUsecase(i())),
        Bind.lazySingleton((i) => EditAppointmentUsecase(i())),
        Bind.lazySingleton((i) => InsertAppointmentUsecase(i())),
        // ui/stores
        Bind.lazySingleton((i) => TicketStore(i(), i(), i(), i(), i())),
        Bind.lazySingleton((i) => AppointmentStore(i(), i(), i(), i(), i())),
        Bind.lazySingleton((i) => AgendaStore(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => MainPage()),
        ChildRoute('/agenda', child: (context, args) => MainPage(screenIndex: 0)),
        ChildRoute('/tickets', child: (context, args) => MainPage(screenIndex: 1)),
      ];
}
