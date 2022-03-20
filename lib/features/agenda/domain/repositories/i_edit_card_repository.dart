import 'package:zione/features/agenda/domain/entities/entry_entity.dart';

abstract class IEditCardRepository {
  Future<bool> call(EntryEntity entry);
}
