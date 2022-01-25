import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

abstract class ICacheDatasource {
  Future<IResponse> saveContent(Endpoint endpoint, IResponse response);
  Future<IResponse> fetchContent(Endpoint endpoint);
}
