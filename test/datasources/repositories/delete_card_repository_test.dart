import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_delete_card_repository.dart';
import 'package:zione/utils/enums.dart';

class DeleteCardRepositoryTest extends IDeleteCardRepository {
  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    return true;
}
