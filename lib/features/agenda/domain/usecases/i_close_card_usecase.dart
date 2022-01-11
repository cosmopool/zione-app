import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/utils/enums.dart';

abstract class ICloseCardUsecase {
  Future<bool> call(EntryEntity entry, Endpoint endpoint);
}

class CloseCardUsecase extends ICloseCardUsecase {
  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
