import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/core/settings.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/features/agenda/data/datasources/local/i_local_datasource.dart';
import 'package:zione/features/agenda/data/repositories/ticket_repository.dart';

import '../../stubs/data/datasource/local_datasource_stub.dart';
import '../../stubs/data/datasource/remote_datasource_stub.dart';
import '../../stubs/ticket_list_stubs.dart';

void main() async {
  late Box box;
  late Box settingsBox;
  late ISettings settings;
  late TicketRepository repo;
  late ILocalDatasource cache;
  final api = RemoteDatasouceStub();
  /* final cache = LocalDatasouceStub(); */
  Map tk = ticketListStub[0];

  setUp(() async {
    await setUpTestHive();
    settingsBox = await Hive.openBox('testSettings');
    box = await Hive.openBox('testCache');
    cache = HiveDatasouce(box);
    settings = Settings(settingsBox);
    repo = TicketRepository(api: api, cache: cache, settings: settings);
  });

  test('should return true on server response status == success', () async {
    api.successfulFetch = true;
    final response = await repo.fetch();
    expect(response, right(ticketListStub));
  });

  test('should return Failure on server response status == error', () async {
    api.successfulFetch = false;
    final response = await repo.fetch();
    expect(response, left(ServerSideFailure()));
  });

  test('should save successful api fetch on cache', () async {
    late List<Map> result;

    api.successfulFetch = true;
    final _api = await repo.fetch();
    _api.fold((l) => null, (r) => result = r);

    final cacheRes = await box.get(Endpoint.tickets.name);
    expect(_api.isRight(), true);
    expect(_api, right(cacheRes));
  });

  test('should fetch api if cache fails', () async {
    late List<Map> result;

    // setup repository
    final _cache = LocalDatasouceStub();
    final _repo = TicketRepository(api: api, cache: _cache, settings: settings);

    _cache.successfulFetch = false;

    // fetch so [_lastFetch] is set to DateTime.now()
    await _repo.fetch();
    // injecting different list from api response
    await box.put(Endpoint.tickets.name, [ticketListStub[1]]);

    final res = await _repo.fetch();
    res.fold((l) => null, (r) => result = r);
    expect(result, ticketListStub);
  });

  test('should fetch cache if [lastFetch] is < settings', () async {
    late List<Map> result;

    // fetch so [_lastFetch] is set to DateTime.now()
    await repo.fetch();

    
    // injecting different list from api response
    await box.put(Endpoint.tickets.name, [ticketListStub[1]]);

    final res = await repo.fetch();
    res.fold((l) => null, (r) => result = r);
    expect(result, [ticketListStub[1]]);
  });

  test('should fetch cache if api fails', () async {
    late List<Map> result;
    /* late List<Map> result; */

    // injecting different list from api response
    await box.put(Endpoint.tickets.name, [ticketListStub[0]]);

    api.successfulFetch = false;
    final res = await repo.fetch();
    final cacheRes = await box.get(Endpoint.tickets.name);
    res.fold((l) => null, (r) => result = r);
    expect(cacheRes, [ticketListStub[0]]);
    expect(result, [ticketListStub[0]]);
  });

  test('should return error if api and cache fails', () async {
    // setup repository
    final _cache = LocalDatasouceStub();
    final _repo = TicketRepository(api: api, cache: _cache, settings: settings);

    _cache.successfulFetch = false;
    api.successfulFetch = false;

    final res = await _repo.fetch();
    expect(res, Left(ServerSideFailure()));
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
