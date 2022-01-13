import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';
import 'package:zione/features/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/domain/usecases/i_delete_card_usecase.dart';
import 'package:zione/utils/enums.dart';

class DeleteCardUsecaseTest extends IDeleteCardUseCase {
  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    final entryClass = entry.runtimeType;
    var res = false;

    if (endpoint == Endpoint.agenda || entryClass == AgendaEntryEntity) {
      res = true;
    }
    if (endpoint == Endpoint.tickets || entryClass == TicketEntity) {
      res = true;
    }
    if (endpoint == Endpoint.appointments || entryClass == AppointmentEntity) {
      res = true;
    }

    return res;
  }
}
