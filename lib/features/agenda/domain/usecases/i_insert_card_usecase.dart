import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_insert_card_repository.dart';
import 'package:zione/utils/enums.dart';

abstract class IInsertCardUseCase {
  Future<bool> call(EntryEntity entry, Endpoint endpoint);
}

class InsertCardUseCase extends IInsertCardUseCase {
  final IInsertCardRepository _repository;

  InsertCardUseCase(this._repository);

  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    final result = await _repository(entry, endpoint);
    return result;
  }
}
