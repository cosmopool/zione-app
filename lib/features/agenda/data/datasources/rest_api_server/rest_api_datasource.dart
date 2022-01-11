import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zione/core/auth.dart' as auth_config;
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/utils/constants.dart' as conf;
import 'package:zione/utils/enums.dart';

class RestApiServerDataSource {
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': auth_config.token
  };

  String _parseEndpoint(Endpoint endpoint) {
    late String endpointStr;

    switch (endpoint) {
      case Endpoint.tickets:
        {
          endpointStr = "tickets";
        }
        break;
      case Endpoint.appointments:
        {
          endpointStr = "appointments";
        }
        break;
      case Endpoint.agenda:
        {
          endpointStr = "agenda";
        }
        break;
    }

    return endpointStr;
  }

  @override
  Future<Response> fetchContentFromServer(Endpoint endpoint) async {
    // fetch content from rest api
    Map result;

    final _endpoint = _parseEndpoint(endpoint);
    final url = Uri.http("${conf.host}:${conf.port}", "/$_endpoint");
    final response = await http.get(url, headers: _headers);

    result = jsonDecode(response.body);

    return Response(result);
  }

  @override
  Future<Response> postContentToServer(Endpoint endpoint, Map content) async {
    // post content to rest api
    Map result;

    final _endpoint = _parseEndpoint(endpoint);
    final url = Uri.http("${conf.host}:${conf.port}", "/$_endpoint");
    final response =
        await http.post(url, headers: _headers, body: jsonEncode(content));
    result = jsonDecode(response.body);

    return Response(result);
  }

  @override
  Future<Response> updateContentFromServer(
      Endpoint endpoint, Map content) async {
    // close content from rest api
    Map result;

    final _endpoint = _parseEndpoint(endpoint);
    final id = content['id'];
    final validEndpoint = "$_endpoint/$id";
    final url = Uri.http("${conf.host}:${conf.port}", "/$validEndpoint");
    final response =
        await http.patch(url, headers: _headers, body: jsonEncode(content));

    result = jsonDecode(response.body);

    return Response(result);
  }

  @override
  Future<Response> closeContentFromServer(
      Endpoint endpoint, Map content) async {
    // close content from rest api
    Map result;

    final _endpoint = _parseEndpoint(endpoint);
    final id = content['id'];
    final validEndpoint = "$_endpoint/$id/actions/close";
    final url = Uri.http("${conf.host}:${conf.port}", "/$validEndpoint");
    final response =
        await http.post(url, headers: _headers, body: jsonEncode(content));

    result = jsonDecode(response.body);

    return Response(result);
  }

  @override
  Future<Response> deleteContentFromServer(
      Endpoint endpoint, Map content) async {
    // delete content from rest api
    Map result;

    final _endpoint = _parseEndpoint(endpoint);
    final id = content['id'];
    final validEndpoint = "$_endpoint/$id";
    final url = Uri.http("${conf.host}:${conf.port}", "/$validEndpoint");
    final response =
        await http.delete(url, headers: _headers, body: jsonEncode(content));

    result = jsonDecode(response.body);

    return Response(result);
  }
}
