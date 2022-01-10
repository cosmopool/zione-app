import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/domain/entities/entry_model.dart';

abstract class FeedRepositoryInterface {
  Future<ResponseStatus> fetch(Endpoint endpoint);
  Future<ResponseStatus> insert(Endpoint endpoint, Entry entry);
  Future<ResponseStatus> delete(Endpoint endpoint, Entry entry);
  Future<ResponseStatus> close(Endpoint endpoint, Entry entry);
}
