import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

abstract class ICacheDatasource {
  IResponse saveContent(Endpoint endpoint, List listOfContent);
  IResponse fetchContent(Endpoint endpoint);
}
