import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

final log = Logger('ApiHelperMethods');

/// Convert api response message to [Failure] object
Failure convertApiMessageToError(String apiError) {
  bool contains(x) => apiError.contains(x);
  if (contains("UnformattedResponse")) return UnformattedResponse();

  if (contains("DatabaseError")) return DatabaseError();

  if (contains("MissingFieldError")) return MissingFieldError();
  if (contains("One or more missing fields: ")) return MissingFieldError();

  if (contains("InvalidValueError")) return InvalidValueError();
  if (contains("more invalid character used in '")) return InvalidValueError();

  if (contains("ValidationError")) return ValidationError();
  if (contains("occured validating the data sent: ")) return ValidationError();

  if (contains("Confirm your credentials.")) return WrongCredentials();

  if (contains("GenericError")) return ServerSideFailure();
  if (contains("One or more error occured: ")) return ServerSideFailure();

  return UnformattedResponse();
}

/// Convert an response from a http api request to [bool] or [Failure]
Either<Failure, List> convertApiResponseToList(Response response) {
  final statusCode = response.statusCode;
  final body = response.body;
  final result = jsonDecode(body);
  log.finest("[API][REQUEST] request sent to server: ${response.request}");
  log.finest("[API][RESPONSE] http code: $statusCode, body: $body");
  log.info("[API][RESPONSE] converting response to [Failure] or [bool]");

  /* print("body: $result"); */
  if (result['Status'] == "Success") {
    log.info("[API][RESPONSE] successful response");
    return right(result['Result']);
  } else {
    final error =
        convertApiMessageToError(result['Result'] ?? "UnformattedResponse");
    log.severe("[API][RESPONSE] response contains an error: $error");
    return left(error);
  }
}

/// Convert an response from a http api request to [bool] or [Failure]
Either<Failure, bool> convertApiResponseToBool(Response response) {
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

class ApiHelper<Output> {
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
  Future<Either<Failure, Output>> handleRequestErrors(
      Future<Either<Failure, Output>> Function() apiRequest) async {
    try {
      return await apiRequest();
    } on SocketException {
      return left(NoConnectionWithServer());
    } catch (e) {
      return left(ServerSideFailure());
    }
  }
}
