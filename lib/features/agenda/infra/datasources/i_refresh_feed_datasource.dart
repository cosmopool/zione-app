import 'package:zione/utils/enums.dart';

import 'i_response_api_request.dart';

abstract class IRefreshFeedDataSouce {
  Future<IResponse> call(Endpoint endpoint);
}

