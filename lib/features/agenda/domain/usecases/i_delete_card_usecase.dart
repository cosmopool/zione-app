import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';

abstract class IDeleteCardUseCase {
  Future<bool> call(EntryEntity entry, Endpoint endpoint);
}

class DeleteCardUseCase extends IDeleteCardUseCase {
  final IDeleteCardRepository _repository;

  DeleteCardUseCase({required repository}) : _repository = repository;

  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
