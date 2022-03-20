import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/utils/enums.dart';

abstract class IInsertCardDataSource {
  Future<bool> call(EntryEntity entry, Endpoint endpoint);
}
