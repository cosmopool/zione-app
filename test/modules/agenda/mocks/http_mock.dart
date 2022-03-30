import 'dart:convert';

import 'package:http/http.dart';

class HttpMock {
  late Response response;
  late Uri url;

  Future<Response> post(
    Uri, {
    Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
  }) async =>
      response;

  Future<Response> patch(
    Uri, {
    Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
  }) async =>
      response;

  Future<Response> delete(
    Uri, {
    Object? body,
    Encoding? encoding,
    Map<String, String>? headers,
  }) async =>
      response;

  Future<Response> get(
    Uri, {
    Map<String, String>? headers,
  }) async =>
      response;

  /* Future<Uri> uri(String, String, [Map<String, dynamic>?],) async => url; */
}
