import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_close_card_repository.dart';
import 'package:zione/features/agenda/infra/datasources/i_close_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class CloseCardRepository extends ICloseCardRepository {
  final ICloseCardDataSouce _repository;

  CloseCardRepository(this._repository);

  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    bool result = false;

    final IResponse response = await _repository(entry, endpoint);
    (response.status == ResponseStatus.success) ? result = true : result = false;

    return result;
  }
}