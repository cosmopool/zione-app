import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_insert_card_repository.dart';
import 'package:zione/features/agenda/infra/datasources/i_insert_card_datasource.dart';
import 'package:zione/utils/enums.dart';

class InsertCardRepository extends IInsertCardRepository {
  final IInsertCardDataSource _datasource;

  InsertCardRepository(this._datasource);

  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    return await _datasource(entry, endpoint);
  }
}
