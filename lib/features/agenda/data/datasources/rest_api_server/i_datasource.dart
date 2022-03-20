import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/utils/enums.dart';

abstract class IApiDatasource {
  Future<Response> fetchContent(Endpoint endpoint);
  Future<Response> postContent(Endpoint endpoint, Map content);
  Future<Response> updateContent(Endpoint endpoint, Map content);
  Future<Response> closeContent(Endpoint endpoint, Map content);
  Future<Response> deleteContent(Endpoint endpoint, Map content);
}
