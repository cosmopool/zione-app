import 'package:zione/features/agenda/data/datasources/local/cache_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';

class HiveDatasouce extends ICacheDatasource {
  List listOfFetchedContent = [];

  @override
  IResponse fetchContent() {
    final response = Response({'Status': 'Success', 'Result': listOfFetchedContent});
    return response;
  }

  @override
  IResponse saveContent(List listOfContent) {
    listOfFetchedContent = listOfContent;
    final response = Response({'Status': 'Success', 'Result': 'Saved!'});
    return response;
  }
}
