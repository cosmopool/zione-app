import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/data/mappers/appointment_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_appointments.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

class AppointmentStore extends NotifierStore<Failure, List<AppointmentEntity>> {
  final FetchAppointmentsUsecase _usecase;
  final log = Logger('AppointmentStore');

  AppointmentStore(this._usecase) : super([]);

  Future<void> fetch() async {
    log.info("[APPOINTMENT][STORE] -- FETCHING APPOINTMENTS...");
    setLoading(true);

    final list = await _usecase();
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
}
