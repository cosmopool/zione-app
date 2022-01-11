import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

abstract class IRefreshFeedRepository {
  Future<IResponse> call(Endpoint endpoint);
}
