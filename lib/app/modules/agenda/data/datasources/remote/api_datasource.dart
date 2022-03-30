import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/services/helper_methods.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/core/utils/enums.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/i_remote_datasource.dart';

class ApiServerDataSource implements IRemoteDatasource {
  final log = Logger('ApiDatasource');
  ISettings settings;
  final apiHelper = ApiHelper<bool>();
  late Function(String, String, [Map<String, dynamic>?]) uriMethod;
  late Function(Uri, {Map<String, String>? headers}) httpGet;
  late Function(Uri, {Object? body, Encoding? encoding, Map<String, String>? headers}) httpPost;
  late Function(Uri, {Object? body, Encoding? encoding, Map<String, String>? headers}) httpDelete;
  late Function(Uri, {Object? body, Encoding? encoding, Map<String, String>? headers}) httpPatch;

  ApiServerDataSource({
    required this.settings,
    this.uriMethod = Uri.https,
    this.httpGet = http.get,
    this.httpPost = http.post,
    this.httpDelete = http.delete,
    this.httpPatch = http.patch,
  });

  Future<Map<String, String>> _headers() async {
    final token = await settings.token;

    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  /// Fetch content from rest api
  @override
  Future<Either<Failure, List<Map>>> fetchContent(Endpoint endpoint) async {
    try {
      final Uri url = uriMethod(await settings.host, "/${endpoint.name}");
      log.info("[API][FETCH] Fetching content from: $url");
      final http.Response response = await httpGet(url, headers: await _headers());

      final statusCode = response.statusCode;
      final body = response.body;
      final result = jsonDecode(body);
      log.finest("[API][REQUEST] request sent to server: ${response.request}");
      log.finest("[API][RESPONSE] http code: $statusCode, body: $body");
      /* print("[API][RESPONSE] http code: $statusCode, body: $body"); */
      log.info("[API][RESPONSE] converting response to [Failure] or [bool]");

      if (result['Status'] == "Success") {
        log.info("[API][RESPONSE] successful response");
        final res = List<Map>.from(result['Result']);
        return right(res);
      } else {
        final error = convertApiMessageToError(result['Result']);
        log.severe("[API][RESPONSE] response contains an error: $error");
        return left(error);
      }
    } on SocketException {
      return left(NoConnectionWithServer());
    } catch (e) {
      return left(ServerSideFailure());
    }
  }

  /// Post content to rest api
  @override
  Future<Either<Failure, bool>> postContent(
      Endpoint endpoint, Map content) async {
    return apiHelper.handleRequestErrors(() async {
      final url = uriMethod(await settings.host, "/${endpoint.name}");
      log.info("[API][POST] Trying to post on server: $url");

      final http.Response response = await httpPost(
        url,
        headers: await _headers(),
        body: jsonEncode(content),
      );

      return convertApiResponseToBool(response);
    });
  }

  /// Update content from rest api
  @override
  Future<Either<Failure, bool>> updateContent(
      Endpoint endpoint, Map content) async {
    return apiHelper.handleRequestErrors(() async {
      final url = uriMethod(await settings.host, "/${endpoint.name}/${content['id']}");
      log.info("[API][PATCH] trying to patch on server: $url");

      final http.Response response = await httpPatch(
        url,
        headers: await _headers(),
        body: jsonEncode(content),
      );

      return convertApiResponseToBool(response);
    });
  }

  /// Close content from rest api
  @override
  Future<Either<Failure, bool>> closeContent(
      Endpoint endpoint, Map content) async {
    return apiHelper.handleRequestErrors(() async {
      final url = uriMethod(
        await settings.host,
        "/${endpoint.name}/${content['id']}/actions/close",
      );
      log.info("[API][POST] Trying to post to close on server: $url");

      final http.Response response = await httpPost(
        url,
        headers: await _headers(),
        body: jsonEncode(content),
      );

      return convertApiResponseToBool(response);
    });
  }

  /// Delete content from rest api
  @override
  Future<Either<Failure, bool>> deleteContent(
      Endpoint endpoint, Map content) async {
    return apiHelper.handleRequestErrors(() async {
      final url = uriMethod(await settings.host, "/${endpoint.name}/${content['id']}");
      log.info("[API][PATCH] Trying to delete on server: $url");

      final http.Response response = await httpDelete(
        url,
        headers: await _headers(),
        body: jsonEncode(content),
      );

      return convertApiResponseToBool(response);
    });
  }
}
