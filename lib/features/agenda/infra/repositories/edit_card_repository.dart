import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_edit_card_repository.dart';
import 'package:zione/features/agenda/infra/datasources/i_edit_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class EditCardRepository extends IEditCardRepository {
  final IEditCardDataSouce _repository;

  EditCardRepository(this._repository);

  @override
  Future<bool> call(EntryEntity entry) async {
    bool result = false;

    final IResponse response = await _repository(entry);
    (response.status == ResponseStatus.success) ? result = true : result = false;

    return result;
  }
}
