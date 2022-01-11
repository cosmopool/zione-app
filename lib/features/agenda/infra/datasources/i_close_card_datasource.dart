import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/utils/enums.dart';

import 'i_response_api_request.dart';

abstract class ICloseCardDataSouce {
  Future<IResponse> call(EntryEntity entry, Endpoint endpoint);
}

