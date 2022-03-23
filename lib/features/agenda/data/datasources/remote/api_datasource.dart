import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:zione/core/auth.dart' as auth;
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/core/utils/constants.dart' as conf;
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/i_datasource.dart';

class ApiServerDataSource implements IDatasource {
  final log = Logger('ApiDatasource');
  late Uri Function(String, String, [Map<String, dynamic>?]) uriMethod = Uri.https;

  ApiServerDataSource({required this.uriMethod});

  Map<String, String> _headers() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth.token}'
    };
  }

  Future<Either<Failure, String>> authenticate(Map<String, String> credentials) async {
    final url = uriMethod(conf.host, "/login");
    log.info("[API][FETCH] initiating authentication on: $url");
    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(credentials),
    );

    final statusCode = response.statusCode;
    final body = response.body;
    final result = jsonDecode(body);
    log.finest("[API][REQUEST] request sent to server: ${response.request}");
    log.finest("[API][RESPONSE] response http code: $statusCode, body: $body");

    log.info("[API][RESPONSE] converting response to [Failure] or [bool]");
    if (result['Status'] == "Success") {
      log.info("[API][RESPONSE] successful response");
      final String res = result['Result'];
      return right(res);
    } else {
      final error = convertApiMessageToError(result['Result']);
      log.severe("[API][RESPONSE] response contains an error: $error");
      return left(error);
    }
  }

  /// Fetch content from rest api
  @override
  Future<Either<Failure, List<Map>>> fetchContent(Endpoint endpoint) async {
    final url = uriMethod(conf.host, "/${endpoint.name}");
    log.info("[API][FETCH] Fetching content from: $url");
    final response = await http.get(url, headers: _headers());

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
  }

  /// Post content to rest api
  @override
  Future<Either<Failure, bool>> postContent(
      Endpoint endpoint, Map content) async {
    return handleRequestErrors(() async {
      final url = uriMethod(conf.host, "/${endpoint.name}");
      log.info("[API][POST] Trying to post on server: $url");

      final response = await http.post(
        url,
        headers: _headers(),
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
      final url = uriMethod(conf.host, "/${endpoint.name}/${content['id']}");
      log.info("[API][PATCH] trying to patch on server: $url");

      final response = await http.patch(
        url,
        headers: _headers(),
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
        conf.host,
        "/${endpoint.name}/${content['id']}/actions/close",
      );
      log.info("[API][POST] Trying to post to close on server: $url");

      final response = await http.post(
        url,
        headers: _headers(),
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
      final url = uriMethod(conf.host, "/${endpoint.name}/${content['id']}");
      log.info("[API][PATCH] Trying to delete on server: $url");

      final response = await http.delete(
        url,
        headers: _headers(),
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
      final error = convertApiMessageToError(result['Result'] ?? "UnformattedResponse");
      log.severe("[API][RESPONSE] response contains an error: $error");
      return left(error);
    }
  }

  /// Convert api response message to [Failure] object
  Failure convertApiMessageToError(String apiError) {
    if (apiError.contains("UnformattedResponse")) return UnformattedResponse();

    if (apiError.contains("DatabaseError")) return DatabaseError();

    if (apiError.contains("MissingFieldError")) return MissingFieldError();
    if (apiError.contains("One or more missing fields: ")) return MissingFieldError();

    if (apiError.contains("InvalidValueError")) return InvalidValueError();
    if (apiError.contains("One or more invalid character used in '")) return InvalidValueError();

    if (apiError.contains("ValidationError")) return ValidationError();
    if (apiError.contains("One or more error occured validating the data sent: ")) return ValidationError();

    if (apiError.contains("GenericError")) return ServerSideFailure();
    if (apiError.contains("One or more error occured: ")) return ServerSideFailure();
    return ServerSideFailure();
    /* switch (apiError) { */
    /*   case "GenericError": */
    /*     return left(ServerSideFailure()); */
    /**/
    /*   case "MissingFieldError": */
    /*     return left(MissingFieldError()); */
    /*    */
    /*   case "DatabaseError": */
    /*     return left(DatabaseError()); */
    /**/
    /*   case "InvalidValueError": */
    /*     return left(InvalidValueError()); */
    /**/
    /*   case "ValidationError": */
    /*     return left(ValidationError()); */
    /**/
    /*   default: */
    /*     return left(ServerSideFailure()); */
    /* } */
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
  /// final response = await http.post(endpoint, json);
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
