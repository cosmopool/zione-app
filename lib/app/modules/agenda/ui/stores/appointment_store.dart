import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/data/mappers/appointment_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/usecases/close_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/delete_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/edit_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_appointments.dart';
import 'package:zione/app/modules/agenda/domain/usecases/insert_appointment_usecase.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

class AppointmentStore extends NotifierStore<Failure, List<AppointmentEntity>> {
  final FetchAppointmentsUsecase fetchUsecase;
  final InsertAppointmentUsecase insertUsecase;
  final DeleteAppointmentUsecase deleteUsecase;
  final CloseAppointmentUsecase closeUsecase;
  final EditAppointmentUsecase editUsecase;
  final log = Logger('AppointmentStore');

  AppointmentStore(
    this.fetchUsecase,
    this.insertUsecase,
    this.deleteUsecase,
    this.closeUsecase,
    this.editUsecase,
  ) : super([]);

  Future<void> fetch() async {
    log.info("[APPOINTMENT][STORE] -- FETCHING APPOINTMENTS...");
    setLoading(true);

    final list = await fetchUsecase();
    list.fold((failure) {
      log.info("[APPOINTMENT][STORE] a failure occured");
      if (failure == AuthTokenError()) {
        Modular.to.pushNamedAndRemoveUntil('/login/', (_) => false);
      }
      setError(failure);
    }, (ticketList) {
      final result = AppointmentMapper.fromMapList(ticketList);
      update(result);
    });

    setLoading(false);
  }

  /// Insert a given appointment
  Future<void> insert(AppointmentEntity ap) async {
    setLoading(true);
    final result = await insertUsecase(ap);
    result.fold((l) => setError(l), (r) => fetch());
    setLoading(false);
  }

  /// Delete a given appointment
  Future<void> delete(AppointmentEntity ap) async {
    setLoading(true);
    final result = await deleteUsecase(ap);
    result.fold((l) => setError(l), (r) => fetch());
    setLoading(false);
  }

  /// Close a given appointment
  Future<void> close(AppointmentEntity ap) async {
    setLoading(true);
    final result = await closeUsecase(ap);
    result.fold((l) => setError(l), (r) => fetch());
    setLoading(false);
  }

  /// Edit a given appointment
  Future<void> edit(AppointmentEntity ap) async {
    setLoading(true);
    final result = await editUsecase(ap);
    result.fold((l) => setError(l), (r) => fetch());
    setLoading(false);
  }
}
