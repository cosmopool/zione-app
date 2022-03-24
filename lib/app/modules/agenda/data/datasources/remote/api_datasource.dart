import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/core/utils/enums.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/i_remote_datasource.dart';

class ApiServerDataSource implements IRemoteDatasource {
  final log = Logger('ApiDatasource');
  ISettings settings;
  late Uri Function(String, String, [Map<String, dynamic>?]) uriMethod;
  late Future<http.Response> Function(Uri, {Map<String, String>? headers})
      httpGet;
  late Future<http.Response> Function(Uri,
      {Object? body,
      Encoding? encoding,
      Map<String, String>? headers}) httpPost;
  late Future<http.Response> Function(Uri,
      {Object? body,
      Encoding? encoding,
      Map<String, String>? headers}) httpDelete;
  late Future<http.Response> Function(Uri,
      {Object? body,
      Encoding? encoding,
      Map<String, String>? headers}) httpPatch;

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

  /// Post login [credentials] to the api asking for a authentication [token]
  /* Future<Either<Failure, String>> authenticate( */
  /*     Map<String, String> credentials) async { */
  /*   try { */
  /*     final url = uriMethod(await settings.host, "/login"); */
  /*     log.info("[API][FETCH] initiating authentication on: $url"); */
  /*     final response = await httpPost( */
  /*       url, */
  /*       headers: _headers(), */
  /*       body: jsonEncode(credentials), */
  /*     ); */
  /**/
  /*     final statusCode = response.statusCode; */
  /*     final body = response.body; */
  /*     final result = jsonDecode(body); */
  /*     log.finest("[API][REQUEST] request sent to server: ${response.request}"); */
  /*     log.finest( */
  /*         "[API][RESPONSE] response http code: $statusCode, body: $body"); */
  /**/
  /*     log.info("[API][RESPONSE] converting response to [Failure] or [bool]"); */
  /*     if (result['Status'] == "Success") { */
  /*       log.info("[API][RESPONSE] successful response"); */
  /*       final String res = result['Result']; */
  /*       return right(res); */
  /*     } else { */
  /*       final error = convertApiMessageToError(result['Result']); */
  /*       log.severe("[API][RESPONSE] response contains an error: $error"); */
  /*       return left(error); */
  /*     } */
  /*   } on SocketException { */
  /*     return left(NoConnectionWithServer()); */
  /*   } catch (e) { */
  /*     return left(ServerSideFailure()); */
  /*   } */
  /* } */

  /// Fetch content from rest api
  @override
  Future<Either<Failure, List<Map>>> fetchContent(Endpoint endpoint) async {
    try {
      final url = uriMethod(await settings.host, "/${endpoint.name}");
      log.info("[API][FETCH] Fetching content from: $url");
      final response = await httpGet(url, headers: await _headers());

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
    return handleRequestErrors(() async {
      final url = uriMethod(await settings.host, "/${endpoint.name}");
      log.info("[API][POST] Trying to post on server: $url");

      final response = await httpPost(
        url,
        headers: await _headers(),
        body: jsonEncode(content),
      );

      return convertApiResponse(response);
    });
  }

  /// Update content from rest api
  @override
  Future<Either<Failure, bool>> updateContent(
      Endpoint endpoint, Map content) async {
    return handleRequestErrors(() async {
      final url = uriMethod(await settings.host, "/${endpoint.name}/${content['id']}");
      log.info("[API][PATCH] trying to patch on server: $url");

      final response = await httpPatch(
        url,
        headers: await _headers(),
        body: jsonEncode(content),
      );

      return convertApiResponse(response);
    });
  }

  /// Close content from rest api
  @override
  Future<Either<Failure, bool>> closeContent(
      Endpoint endpoint, Map content) async {
    return handleRequestErrors(() async {
      final url = uriMethod(
        await settings.host,
        "/${endpoint.name}/${content['id']}/actions/close",
      );
      log.info("[API][POST] Trying to post to close on server: $url");

      final response = await httpPost(
        url,
        headers: await _headers(),
        body: jsonEncode(content),
      );

      return convertApiResponse(response);
    });
  }

  /// Delete content from rest api
  @override
  Future<Either<Failure, bool>> deleteContent(
      Endpoint endpoint, Map content) async {
    return handleRequestErrors(() async {
      final url = uriMethod(await settings.host, "/${endpoint.name}/${content['id']}");
      log.info("[API][PATCH] Trying to delete on server: $url");

      final response = await httpDelete(
        url,
        headers: await _headers(),
        body: jsonEncode(content),
      );

      return convertApiResponse(response);
    });
  }

  /// Convert an response from a http api request to [bool] or [Failure]
  Either<Failure, bool> convertApiResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;
    final result = jsonDecode(body);
    log.finest("[API][REQUEST] request sent to server: ${response.request}");
    log.finest("[API][RESPONSE] http code: $statusCode, body: $body");
    log.info("[API][RESPONSE] converting response to [Failure] or [bool]");

    if (result['Status'] == "Success") {
      log.info("[API][RESPONSE] successful response");
      return right(true);
    } else {
      final error =
          convertApiMessageToError(result['Result'] ?? "UnformattedResponse");
      log.severe("[API][RESPONSE] response contains an error: $error");
      return left(error);
    }
  }

  /// Convert api response message to [Failure] object
  Failure convertApiMessageToError(String apiError) {
    bool contains(x) => apiError.contains(x);
    if (contains("Authentication token error")) return AuthTokenError();

    if (contains("DatabaseError")) return DatabaseError();

    if (contains("MissingFieldError")) return MissingFieldError();
    if (contains("One or more missing fields: ")) return MissingFieldError();

    if (contains("InvalidValueError")) return InvalidValueError();
    if (contains("more invalid character used i'")) return InvalidValueError();

    if (contains("ValidationError")) return ValidationError();
    if (contains("occured validating the data sent")) return ValidationError();

    if (contains("Confirm your credentials.")) return WrongCredentials();

    if (contains("GenericError")) return ServerSideFailure();
    if (contains("One or more error occured: ")) return ServerSideFailure();

    return UnformattedResponse();
  }

  /// Handle errors from request to api
  ///
  /// [apiRequest] is a function that makes a request to an endpoint.
  /// [handleRequestErrors] calls [apiRequest] function and if any error occurs,
  /// it returns left([Failure]). For exemple: left(ServerSideFailure());
  ///
  /// If no errors occurred processing [apiRequest], it returns right(true).
  ///
  /// [apiRequest] should contain aditional logic, for exemple: cache apiRequest
  /// as shown by the snipet below:
  ///
  /// // This snipet is an exemple of [apiRequest] argument with aditional cache logic:
  /// ```dart
  /// final response = await httpPost(endpoint, json);
  ///
  /// if (response.status == Status.success) {
  ///   await cache.save(endpoint, json);
  ///   return right(true);
  /// } else {
  ///   return left(CouldNotSaveJson(response.error));
  /// }
  /// ```
  Future<Either<Failure, bool>> handleRequestErrors(
      Future<Either<Failure, bool>> Function() apiRequest) async {
    try {
      return await apiRequest();
    } on SocketException {
      return left(NoConnectionWithServer());
    } catch (e) {
      return left(ServerSideFailure());
    }
  }
}
