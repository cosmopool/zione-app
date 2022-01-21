import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';

abstract class ICacheDatasource {
  IResponse saveContent(List listOfContent);
  IResponse fetchContent();
}
