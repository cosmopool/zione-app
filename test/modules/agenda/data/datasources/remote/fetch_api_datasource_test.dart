import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/api_datasource.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

import '../../../mocks/http_mock.dart';
import '../../../stubs/data/datasource/settings_stub.dart';
import '../../../stubs/http_response_stub.dart';

void main() async {
  const tkEndpoint = Endpoint.tickets;
  late SettingsStub settings;
  final http = HttpMock();
  String tkResp =
      '{"Status": "Success", "Result": [{"id": 1,"clientName": "Gustavo Micaloski","clientPhone": "41666222888","clientAddress": "Rua Minecraft, 654","serviceType": "Instalacao","description": "Instalar o Minecraft","isFinished": false}]}';
  Map tk = {
    "id": 1,
    "clientName": "Gustavo Micaloski",
    "clientPhone": "41666222888",
    "clientAddress": "Rua Minecraft, 654",
    "serviceType": "Instalacao",
    "description": "Instalar o Minecraft",
    "isFinished": false
  };

  setUp(() async {
    settings = SettingsStub();
  });

  test('should return tiket list when no errors occurr', () async {
    // arrange
    late List<Map> list;
    http.response = Response(tkResp, 200);
    final api = ApiServerDataSource(
      httpGet: http.get,
      settings: settings,
    );
    // act
    final result = await api.fetchContent(tkEndpoint);
    result.fold((l) => null, (r) => list = r);
    expect(list[0], tk);
  });

  test('should return failure on any error', () async {
    // arrange
    http.response = Response(errResp, 400);
    final api = ApiServerDataSource(
      httpGet: http.get,
      settings: settings,
    );
    // act
    final result = await api.fetchContent(tkEndpoint);
    expect(result, left(ServerSideFailure()));
  });

  /* test('should convert url to ticket endpoint', () async { */
  /*   late Response response; */
  /*   // arrange */
  /*   http.response = Response(tkResp, 200); */
  /*   final api = ApiServerDataSource( */
  /*     httpGet: http.get, */
  /*     settings: settings, */
  /*   ); */
  /*   // act */
  /*   final result = await api.fetchContent(tkEndpoint); */
  /*   result.fold((l) => null, (r) => response = r); */
  /*   expect(result, left(ServerSideFailure())); */
  /* }); */
}
