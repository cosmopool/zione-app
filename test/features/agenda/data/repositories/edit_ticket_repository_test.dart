import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:http/http.dart';
import 'package:zione/core/auth.dart';
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/core/errors/cache_errors.dart';
import 'package:zione/core/settings.dart';
import 'package:zione/core/utils/constants.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/features/agenda/data/datasources/local/i_local_datasource.dart';
import 'package:zione/features/agenda/data/datasources/remote/api_datasource.dart';
import 'package:zione/features/agenda/data/repositories/ticket_repository.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';

import '../../stubs/data/datasource/remote_datasource_stub.dart';
import '../../stubs/ticket_list_stubs.dart';

void main() async {
  late Box box;
  late Box settingsBox;
  late ISettings settings;
  late TicketRepository repo;
  late TicketRepository repoApi;
  late ILocalDatasource cache;
  final api = RemoteDatasouceStub();
  Map tk = ticketListStub[0];

  setUp(() async {
    await setUpTestHive();
    host = "0.0.0.0";
    port = "80";
    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY0Nzk4MDcwOCwianRpIjoiODVlNjRmNmYtN2UwZC00ZWY3LWFmZWEtOTQxZmI4MTU0YjgwIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImthaW8iLCJuYmYiOjE2NDc5ODA3MDh9.WnfLrkGrqr7_G7FktuSCrpreUnfsleWesk-AEwqxY6w";
    final _api = ApiServerDataSource(uriMethod: Uri.http);
    settingsBox = await Hive.openBox('testSettings');
    settings = Settings(settingsBox);
    box = await Hive.openBox<List<Map>>('testCache');
    cache = HiveDatasouce(box);
    repo = TicketRepository(api: api, cache: cache, settings: settings);
    repoApi = TicketRepository(api: _api, cache: cache, settings: settings);
  });

  test('should return true on server response status == success', () async {
    await repo.fetch();
    /* await repoApi.fetch(); */
    final _tk = TicketEntity.fromMap(tk);
    _tk.clientName = "huehuehu";
    final response = await repo.edit(_tk);
    /* final response = await repoApi.edit(_tk); */
    expect(response, right(true));
  });

  test('should return EntryNotFound when entry with given id is not on cache', () async {
    await box.put(Endpoint.tickets.name, ticketListStub);
    tk['id'] = -1;
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.edit(_tk);
    expect(response, left(EntryNotFound("")));
  });

  test('should return CouldNotFinishRequest on server response status == error', () async {
    tk['clientName'] = "Error";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.edit(_tk);
    expect(response, left(ServerSideFailure()));
  });

  test('should return NoConnectionWithServer on socket exception', () async {
    tk['clientName'] = "NoConnection";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.edit(_tk);
    expect(response, left(NoConnectionWithServer()));
  });

  test('should return ServerSideFailure on generic error', () async {
    tk['clientName'] = "ServerSide";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.edit(_tk);
    expect(response, left(ServerSideFailure()));
  });

  test('should save successful api edit on cache', () async {
    await repo.fetch();
    final _tk = TicketEntity.fromMap(ticketListStub[0]);
    _tk.clientName = "bazinga";
    final response = await repo.edit(_tk);
    final cacheList = await box.get(Endpoint.tickets.name);
    expect(response, right(true));
    expect(cacheList, ticketListStub);
  });
}
