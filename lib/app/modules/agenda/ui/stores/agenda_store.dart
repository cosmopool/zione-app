import 'package:flutter_triple/flutter_triple.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/agenda/domain/usecases/insert_agenda_entry_usecase.dart';
import 'package:zione/app/modules/agenda/ui/stores/appointment_store.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

class AgendaStore extends NotifierStore<Failure, List<AgendaEntity>> {
  final InsertAgendaUsecase insertUsecase;
  final AppointmentStore store;
  final log = Logger('AgendaStore');

  AgendaStore(
    this.insertUsecase,
    this.store,
  ) : super([]);

  /// Insert a given appointment
  Future<void> insert(AgendaEntity ap) async {
    setLoading(true);
    final result = await insertUsecase(ap);
    result.fold((l) => setError(l), (r) => store.fetch());
    setLoading(false);
  }
}
