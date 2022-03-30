import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/api_datasource.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

import '../../../mocks/http_mock.dart';
import '../../../stubs/data/datasource/settings_stub.dart';
import '../../../stubs/http_response_stub.dart';
import '../../../stubs/ticket_list_stubs.dart';

void main() async {
  const tkEndpoint = Endpoint.tickets;
  late SettingsStub settings;
  final http = HttpMock();
  Map tk = ticketListStub[0];

  setUp(() async {
    settings = SettingsStub();
  });

  test('should return true when given valid input', () async {
    // arrange
    http.response = Response(sucResp, 200);
    final api = ApiServerDataSource(
      httpPost: http.post,
      settings: settings,
    );
    // act
    final result = await api.postContent(tkEndpoint, tk);
    expect(result, right(true));
  });

  test('should return failure on any error', () async {
    // arrange
    http.response = Response(errResp, 400);
    final api = ApiServerDataSource(
      httpPost: http.post,
      settings: settings,
    );
    // act
    final result = await api.postContent(tkEndpoint, tk);
    expect(result, left(ServerSideFailure()));
  });
}
