import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/agenda/data/repositories/ticket_repository.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/cache_errors.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

import '../../stubs/data/datasource/local_datasource_stub.dart';
import '../../stubs/data/datasource/remote_datasource_stub.dart';
import '../../stubs/ticket_list_stubs.dart';

void main() async {
  late Box box;
  late Box settingsBox;
  late ISettings settings;
  late TicketRepository repo;
  late TicketRepository repoHive;
  late LocalDatasouceStub cache;
  late HiveDatasouce _cache;
  final api = RemoteDatasouceStub();

  setUp(() async {
    await setUpTestHive();
    settingsBox = await Hive.openBox('testSettings');
    box = await Hive.openBox('testCache');
    _cache = HiveDatasouce(box);
    cache = LocalDatasouceStub();
    settings = Settings(settingsBox);
    repo = TicketRepository(api, cache, settings);
    repoHive = TicketRepository(api, _cache, settings);
  });

  test('should return true on when no error occurr', () async {
    // arange
    api.shouldFail = false;
    cache.shouldFail = false;
    // act
    final response = await repo.fetch();
    expect(response, right(ticketListStub));
  });

  test('should return api response when some failure occurr only with cache', () async {
    // arange
    api.shouldFail = false;
    cache.shouldFail = true;
    cache.failure = EmptyResponseFromCache();
    // act
    final response = await repo.fetch();
    expect(response, right(ticketListStub));
  });

  test('should pass down AuthTokenError failure from api datasource even if cache ticket list is in cache', () async {
    // arange
    cache.shouldFail = false;
    api.shouldFail = true;
    api.failure = AuthTokenError();
    /* await repo.fetch(); */
    // act
    final response = await repo.fetch();
    expect(response, left(AuthTokenError()));
    expect(response != right(ticketListStub), true);
  });

  test('should pass down any failures from api datasource when api and cache fails', () async {
    // arange
    cache.shouldFail = true;
    api.shouldFail = true;
    api.failure = DatabaseError();
    // act
    final response = await repo.fetch();
    expect(response, left(DatabaseError()));
  });

  test('should save successful api fetch on cache', () async {
    // arange
    api.shouldFail = false;
    await repoHive.fetch();
    // act
    final response = await repoHive.fetch();
    final cacheList = await box.get(Endpoint.tickets.name);
    expect(response, right(ticketListStub));
    expect(cacheList, ticketListStub);
  });
  
  tearDown(() async {
    await tearDownTestHive();
  });
}
