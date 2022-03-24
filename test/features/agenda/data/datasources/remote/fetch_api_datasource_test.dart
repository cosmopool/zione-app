import 'package:flutter_test/flutter_test.dart';
import 'package:zione/core/auth.dart';
import 'package:zione/core/utils/constants.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/remote/api_datasource.dart';
import 'package:zione/features/agenda/data/datasources/remote/i_remote_datasource.dart';

void main() async {
  const tkEndpoint = Endpoint.tickets;
  late IRemoteDatasource api;

  setUp(() async {
    host = "0.0.0.0";
    port = "80";
    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY0Nzk4MDcwOCwianRpIjoiODVlNjRmNmYtN2UwZC00ZWY3LWFmZWEtOTQxZmI4MTU0YjgwIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImthaW8iLCJuYmYiOjE2NDc5ODA3MDh9.WnfLrkGrqr7_G7FktuSCrpreUnfsleWesk-AEwqxY6w";
    api = ApiServerDataSource(uriMethod: Uri.http);
  });

  test('should return list of tickets', () async {
    late List<Map> result;
    final tkRes = {
      "id": 1,
      "clientName": "Gustavo Micaloski",
      "clientPhone": "41666222888",
      "clientAddress": "Rua Minecraft, 654",
      "serviceType": "Instalacao",
      "description": "Instalar o Minecraft",
      "isFinished": false
    };
    final res = await api.fetchContent(tkEndpoint);
    res.fold((l) => null, (r) => result = r);
    /* expect(result.contains(tkRes), true); */
    expect(result.toString(), contains(tkRes.toString()));
  });
}
