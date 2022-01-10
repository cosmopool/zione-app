import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/domain/entities/entry_model.dart';

abstract class CardRepositoryInterface {
  Future<ResponseStatus> edit(Entry entry);
  Future<ResponseStatus> close(Entry entry);
}
