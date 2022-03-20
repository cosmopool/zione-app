import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:zione/core/auth.dart' as auth_config;
import 'package:zione/features/agenda/data/datasources/rest_api_server/i_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/utils/constants.dart' as conf;
import 'package:zione/utils/enums.dart';


class ApiServerDataSource implements IApiDatasource {
  final log = Logger('ApiDatasource');

  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': auth_config.token
  };

  @override
  Future<Response> fetchContent(Endpoint endpoint) async {
    // fetch content from rest api
    Map result;

    final url = Uri.https(conf.host, "/${endpoint.name}");
    log.info("[API][FETCH] Fetching content from: $url");
    try {
      final response = await http.get(url, headers: _headers);
      log.finest("[API][FETCH] Response http code: ${response.statusCode}, body: ${response.body}");
      result = jsonDecode(response.body);
    } on SocketException {
      log.severe("[API][FETCH] No connection with server");
      return Response.noConnection();
    } catch (e) {
      log.severe("[API][FETCH] Error trying to connect: $e");
      return Response.noConnection();
    }

    log.finest("[API][FETCH] Function result: $result");
    return Response.fromMap(result);
  }

  @override
  Future<Response> postContent(Endpoint endpoint, Map content) async {
    // post content to rest api
    final url = Uri.https(conf.host, "/${endpoint.name}");
    log.info("[API][POST] Trying to post on server: $url");

    final response =
        await http.post(url, headers: _headers, body: jsonEncode(content));
    log.finest("[API][POST] Request sent to server: ${response.request}");

    final Map result = jsonDecode(response.body);
    log.finest("[API][POST] Response http code: ${response.statusCode}, body: ${response.body}");

    log.finest("[API][POST] Function result: $result");
    return Response.fromMap(result);
  }

  @override
  Future<Response> updateContent(Endpoint endpoint, Map content) async {
    // close content from rest api
    final url = Uri.https(conf.host, "/${endpoint.name}/${content['id']}");
    log.info("[API][PATCH] Trying to post on server: $url");

    final response =
        await http.patch(url, headers: _headers, body: jsonEncode(content));
    log.finest("[API][PATCH] Request sent to server: ${response.request}");

    final result = jsonDecode(response.body);
    log.finest("[API][PATCH] Response http code: ${response.statusCode}, body: ${response.body}");

    log.finest("[API][PATCH] Function result: $result");
    return Response.fromMap(result);
  }

  @override
  Future<Response> closeContent(Endpoint endpoint, Map content) async {
    // close content from rest api
    Map result;

    final id = content['id'];
    final validEndpoint = "${endpoint.name}/$id/actions/close";
    final url = Uri.https(conf.host, "/$validEndpoint");
    final response =
        await http.post(url, headers: _headers, body: jsonEncode(content));

    result = jsonDecode(response.body);

    return Response.fromMap(result);
  }

  @override
  Future<Response> deleteContent(Endpoint endpoint, Map content) async {
    // delete content from rest api
    Map result;

    final id = content['id'];
    final validEndpoint = "${endpoint.name}/$id";
    final url = Uri.https(conf.host, "/$validEndpoint");
    final response =
        await http.delete(url, headers: _headers, body: jsonEncode(content));

    result = jsonDecode(response.body);

    return Response.fromMap(result);
  }
}
