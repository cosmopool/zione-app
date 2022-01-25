import 'package:hive/hive.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

import 'i_cache_datasource.dart';

class HiveDatasouce extends ICacheDatasource {
  Box box = Hive.box('contentCacheBox');

  String _parseEndpoint(Endpoint endpoint) {
    late String endpointStr;

    switch (endpoint) {
      case Endpoint.tickets:
        endpointStr = 'tickets';
        break;
      case Endpoint.appointments:
        endpointStr = "appointments";
        break;
      case Endpoint.agenda:
        endpointStr = "agenda";
        break;
    }

    return endpointStr;
  }

  @override
  IResponse fetchContent(Endpoint endpoint) {
    final String boxKey = _parseEndpoint(endpoint);
    final List content = box.get(boxKey);
    final response = Response({'Status': 'Success', 'Result': content});

    return response;
  }

  @override
  IResponse saveContent(Endpoint endpoint, List listOfContent) {
    final String boxKey = _parseEndpoint(endpoint);
    box.put(boxKey, listOfContent);
    final response = Response({'Status': 'Success', 'Result': 'Saved!'});

    return response;
  }
}
