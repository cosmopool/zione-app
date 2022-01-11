import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_close_card_repository.dart';
import 'package:zione/utils/enums.dart';

abstract class ICloseCardUsecase {
  Future<bool> call(EntryEntity entry, Endpoint endpoint);
}

class CloseCardUsecase extends ICloseCardUsecase {
  final ICloseCardRepository _repository;

  CloseCardUsecase(this._repository);

  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    final result = await _repository(entry, endpoint);
    return result;
  }
}
