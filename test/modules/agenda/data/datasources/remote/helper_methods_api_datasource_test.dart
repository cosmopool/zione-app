import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/services/helper_methods.dart';

void main() async {
  late ApiHelper<bool> apiHelper;

  setUp(() async {
    apiHelper = ApiHelper<bool>();
  });

  group('convertApiMessageToError', () {
    test('should return DatabaseError', () async {
      const message = "DatabaseErrorasdf99sks";
      final Failure res = convertApiMessageToError(message);
      expect(res, DatabaseError());
    });

    test('should return MissingFieldError', () async {
      const message = "8w8fsadMissingFieldErrora9sdfh";
      final Failure res = convertApiMessageToError(message);
      expect(res, MissingFieldError());
    });

    test('should return MissingFieldError from detailed message', () async {
      const message = "One or more missing fields: {'id': 'Missing field'}";
      final Failure res = convertApiMessageToError(message);
      expect(res, MissingFieldError());
    });

    test('should return InvalidValueError', () async {
      const message = "0asudfasdInvalidValueErrorasdf99sks";
      final Failure res = convertApiMessageToError(message);
      expect(res, InvalidValueError());
    });

    test('should return InvalidValueError from detailed message', () async {
      const message =
          "One or more invalid character used in '{'id': 'Missing field'}";
      final Failure res = convertApiMessageToError(message);
      expect(res, InvalidValueError());
    });

    test('should return ValidationError', () async {
      const message = "as890dfhasValidationErrorasdf99sks";
      final Failure res = convertApiMessageToError(message);
      expect(res, ValidationError());
    });

    test('should return ValidationError from detailed message', () async {
      const message =
          "One or more error occured validating the data sent: {'id': 'Missing field'}";
      final Failure res = convertApiMessageToError(message);
      expect(res, ValidationError());
    });

    test('should return ServerSideFailure', () async {
      const message = "asuidf89GenericErrorasdf99sks";
      final Failure res = convertApiMessageToError(message);
      expect(res, ServerSideFailure());
    });

    test('should return AuthTokenError', () async {
      const message = "AuthTokenError";
      final Failure res = convertApiMessageToError(message);
      expect(res, AuthTokenError());
    });

    test('should return AuthTokenError from detailed message', () async {
      const message = "Authentication token error: Bad Authorization header. Expected 'Authorization: Bearer<JWT>";
      final Failure res = convertApiMessageToError(message);
      expect(res, AuthTokenError());
    });

    test('should return MissingFieldError from detailed message', () async {
      const message = "When any other message appears {'msg': 'Some message from framework or any library'}";
      final Failure res = convertApiMessageToError(message);
      expect(res, UnformattedResponse());
    });
  });


  group('convertApiResponse', () {
    test('should return UnformattedResponse when no Status key is present in response', () async {
      const body = '{"msg": "An error occured"}';
      final res = convertApiResponseToBool(http.Response(body, 300));
      expect(res, left(UnformattedResponse()));
    });

    test('should return UnformattedResponse when Status is error and no Result key is present in response', () async {
      const body = '{"Status": "Error", "msg": "An error occured"}';
      final res = convertApiResponseToBool(http.Response(body, 300));
      expect(res, left(UnformattedResponse()));
    });

    test('should return true when Status: Success', () async {
      const body = '{"Status": "Success", "msg": "Every thing ok"}';
      final res = convertApiResponseToBool(http.Response(body, 200));
      expect(res, right(true));
    });

    test('should return Status even if response has more fields', () async {
      const body = '{"Status": "Success", "Result": "[1]", "msg": "Every thing ok"}';
      final res = convertApiResponseToBool(http.Response(body, 200));
      expect(res, right(true));
    });

    test('should return AuthTokenError', () async {
      const body = '{"Status": "Error", "Result": "Authentication token error: Bad Authorization header. Expected \'Authorization: Bearer<JWT>\'", "message": "Bad Authorization header. Expected \'Authorization: Bearer <JWT>\'"}';
      final res = convertApiResponseToBool(http.Response(body, 200));
      expect(res, left(AuthTokenError()));
    });
  });


  group('handleRequestErrors', () {
    test('should return NoConnectionWithServer on SocketException', () async {
      final res = await apiHelper.handleRequestErrors(() async => throw const SocketException("msg"));
      expect(res, left(NoConnectionWithServer()));
    });

    test('should return ServerSideFailure on any other exception', () async {
      final res = await apiHelper.handleRequestErrors(() async => throw Exception("msg"));
      expect(res, left(ServerSideFailure()));
    });
  });
}
