import 'package:zione/features/agenda/domain/entities/entry_entity.dart';

import 'i_response_api_request.dart';

abstract class IEditCardDataSouce {
  Future<IResponse> call(EntryEntity entry);
}

