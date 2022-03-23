import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/core/auth.dart';
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/core/utils/constants.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/i_datasource.dart';
import 'package:zione/features/agenda/data/datasources/remote/api_datasource.dart';

import '../../../stubs/ticket_list_stubs.dart';

void main() async {
  const tkEndpoint = Endpoint.tickets;
  late IDatasource api;

  setUp(() async {
    host = "0.0.0.0";
    port = "80";
    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY0Nzk4MDcwOCwianRpIjoiODVlNjRmNmYtN2UwZC00ZWY3LWFmZWEtOTQxZmI4MTU0YjgwIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImthaW8iLCJuYmYiOjE2NDc5ODA3MDh9.WnfLrkGrqr7_G7FktuSCrpreUnfsleWesk-AEwqxY6w";
    api = ApiServerDataSource(uriMethod: Uri.http);
  });

  test('should return true when given valid input', () async {
    Map tk = ticketListStub[0];
    tk.remove('id');
    final res = await api.postContent(tkEndpoint, tk);
    expect(res, right(true));
  });

  test('should save a ticket when given valid input', () async {
    late List<Map> fetchRes;
    await api.postContent(tkEndpoint, ticketListStub[0]);
    final fetch = await api.fetchContent(tkEndpoint);
    fetch.fold((l) => null, (r) => fetchRes = r);
    expect(fetchRes.length > 1, true);
  });

  test('should return ServerSideFailure when trying to add entry with id already existent', () async {
    Map tk = ticketListStub[0];
    tk['id'] = 1;
    final res = await api.postContent(tkEndpoint, tk);
    expect(res, left(ServerSideFailure()));
  });

  test('should return MissingFieldError when trying to add ticket is missing required field', () async {
    Map tk = {'id': 5};
    final res = await api.postContent(tkEndpoint, tk);
    expect(res, left(MissingFieldError()));
  });

}
