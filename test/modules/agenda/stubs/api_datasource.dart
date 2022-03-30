import 'package:collection/collection.dart';

import 'package:zione/app/modules/agenda/data/datasources/rest_api_server/i_datasource.dart';
import 'package:zione/app/modules/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/utils/enums.dart';

const Map<String, dynamic> ticketEntry = {
  "id": 1,
  "clientName": "Nicodemos Biancato",
  "clientPhone": "4199955566",
  "clientAddress": "instalar as cameras na casa da frente",
  "serviceType": "instalacao",
  "description":
      "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
  "isFinished": false
};

class ApiServerDatasourceTest extends IApiDatasource {
  @override
  Future<Response> postContent(Endpoint endpoint, Map content) async {
    if (content == ticketEntry && endpoint == Endpoint.tickets) {
      return Response(status: ResponseStatus.success, result: [1]);
    } else {
      return Response.noConnection();
    }
  }

  @override
  Future<Response> closeContent(Endpoint endpoint, Map content) {
    throw UnimplementedError();
  }

  @override
  Future<Response> deleteContent(Endpoint endpoint, Map content) {
    throw UnimplementedError();
  }

  @override
  Future<Response> fetchContent(Endpoint endpoint) {
    throw UnimplementedError();
  }

  @override
  Future<Response> updateContent(Endpoint endpoint, Map content) async {
    if (endpoint == Endpoint.tickets) {
      if (DeepCollectionEquality().equals(content, ticketEntry)) {
        return Response(status: ResponseStatus.success, result: [1]);
      } else {
        return Response.noConnection();
      }
    } else if (endpoint == Endpoint.appointments) {
      return Response.noConnection();
    } else {
      return Response.noConnection();
    }
  }
}

class ErrorApiServerDatasourceTest extends IApiDatasource {
  @override
  Future<Response> closeContent(Endpoint endpoint, Map content) {
    throw UnimplementedError();
  }

  @override
  Future<Response> deleteContent(Endpoint endpoint, Map content) {
    throw UnimplementedError();
  }

  @override
  Future<Response> fetchContent(Endpoint endpoint) {
    throw UnimplementedError();
  }

  @override
  Future<Response> postContent(Endpoint endpoint, Map content) async {
    return Response.noConnection();
  }

  @override
  Future<Response> updateContent(Endpoint endpoint, Map content) {
    throw UnimplementedError();
  }
}
