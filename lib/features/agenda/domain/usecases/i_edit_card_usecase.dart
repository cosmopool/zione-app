import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_edit_card_repository.dart';
import 'package:zione/utils/enums.dart';

abstract class IEditCardUsecase {
  Future<bool> call(EntryEntity entry, Endpoint endpoint);
}

class EditCardUsecase extends IEditCardUsecase {
  final IEditCardRepository _repository;

  EditCardUsecase(this._repository);

  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    final result = await _repository(entry, endpoint);
    return result;
  }
}
