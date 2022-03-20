import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';
import 'package:zione/features/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/domain/usecases/i_edit_card_usecase.dart';
import 'package:zione/utils/enums.dart';

class EditCardUsecaseTest extends IEditCardUsecase {
  @override
  Future<bool> call(EntryEntity entry) async {
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

    print('res from edit test class');
    print(res);
    return res;
  }
}
