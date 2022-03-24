import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/services/helper_methods.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/login/data/datasources/remote/i_api_datasource.dart';

class ApiAuthDatasource implements IApiAuthDatasource {
  final log = Logger('ApiDatasource');
  final apiHelper = ApiHelper<String>();
  final ISettings settings;
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
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

  ApiAuthDatasource({
    required this.settings,
    this.uriMethod = Uri.https,
    this.httpGet = http.get,
    this.httpPost = http.post,
    this.httpDelete = http.delete,
    this.httpPatch = http.patch,
  });

  @override
  Future<Either<Failure, String>> call(Map credentials) async {
    return apiHelper.handleRequestErrors(() async {
      final url = uriMethod(await settings.host, "/login");
      log.info("[API][FETCH] initiating authentication on: $url");

      final response = await httpPost(
        url,
        headers: headers,
        body: jsonEncode(credentials),
      );

      late List list;
      late Failure failure;
      final res = convertApiResponseToList(response);
      res.fold((l) => failure = l, (r) => list = r);

      return res.isRight() ? Right(list[0]) : Left(failure);
    });
  }
}
