import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/core/utils/constants.dart';
import 'package:zione/features/agenda/data/datasources/remote/api_datasource.dart';

void main() async {
  late ApiServerDataSource api;

  setUp(() async {
    host = "0.0.0.0";
    port = "80";
    api = ApiServerDataSource(uriMethod: Uri.http);
  });

  group('convertApiMessageToError', () {
    test('should return DatabaseError', () async {
      const message = "DatabaseErrorasdf99sks";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, DatabaseError());
    });

    test('should return MissingFieldError', () async {
      const message = "8w8fsadMissingFieldErrora9sdfh";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, MissingFieldError());
    });

    test('should return MissingFieldError from detailed message', () async {
      const message = "One or more missing fields: {'id': 'Missing field'}";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, MissingFieldError());
    });

    test('should return InvalidValueError', () async {
      const message = "0asudfasdInvalidValueErrorasdf99sks";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, InvalidValueError());
    });

    test('should return InvalidValueError from detailed message', () async {
      const message =
          "One or more invalid character used in '{'id': 'Missing field'}";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, InvalidValueError());
    });

    test('should return ValidationError', () async {
      const message = "as890dfhasValidationErrorasdf99sks";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, ValidationError());
    });

    test('should return ValidationError from detailed message', () async {
      const message =
          "One or more error occured validating the data sent: {'id': 'Missing field'}";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, ValidationError());
    });

    test('should return ServerSideFailure', () async {
      const message = "asuidf89GenericErrorasdf99sks";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, ServerSideFailure());
    });

    test('should return MissingFieldError from detailed message', () async {
      const message = "When any other message appears {'id': 'Missing field'}";
      final Failure res = api.convertApiMessageToError(message);
      expect(res, ServerSideFailure());
    });
  });


  group('convertApiResponse', () {
    test('should return UnformattedResponse when no Status key is present in response', () async {
      const body = '{"msg": "An error occured"}';
      final res = api.convertApiResponse(http.Response(body, 300));
      expect(res, left(UnformattedResponse()));
    });

    test('should return UnformattedResponse when Status is error and no Result key is present in response', () async {
      const body = '{"Status": "Error", "msg": "An error occured"}';
      final res = api.convertApiResponse(http.Response(body, 300));
      expect(res, left(UnformattedResponse()));
    });

    test('should return true when Status: Success', () async {
      const body = '{"Status": "Success", "msg": "Every thing ok"}';
      final res = api.convertApiResponse(http.Response(body, 200));
      expect(res, right(true));
    });
  });


  group('handleRequestErrors', () {
    test('should return NoConnectionWithServer on SocketException', () async {
      final res = await api.handleRequestErrors(() async => throw const SocketException("msg"));
      expect(res, left(NoConnectionWithServer()));
    });

    test('should return ServerSideFailure on any other exception', () async {
      final res = await api.handleRequestErrors(() async => throw Exception("msg"));
      expect(res, left(ServerSideFailure()));
    });
  });
}
