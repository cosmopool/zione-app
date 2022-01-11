import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_delete_card_repository.dart';
import 'package:zione/utils/enums.dart';

abstract class IDeleteCardUseCase {
  Future<bool> call(EntryEntity entry, Endpoint endpoint);
}

class DeleteCardUseCase extends IDeleteCardUseCase {
  final IDeleteCardRepository _repository;

  DeleteCardUseCase(this._repository);

  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    final result = await _repository(entry, endpoint);
    return result;
  }
}
