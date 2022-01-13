import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_insert_card_repository.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class InsertCardRepositoryTest implements IInsertCardRepository {
  @override
  Future<IResponse> call(EntryEntity entry, Endpoint endpoint) {

  }
}
