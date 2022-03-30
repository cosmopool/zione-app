import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/agenda/data/repositories/ticket_repository.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
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
  late HiveDatasouce _cache;
  late LocalDatasouceStub cache;
  late TicketRepository repoHive;
  late TicketEntity tk;
  final api = RemoteDatasouceStub();

  setUp(() async {
    await setUpTestHive();
    tk = TicketEntity.fromMap(ticketListStub[0]);
    settingsBox = await Hive.openBox('testSettings');
    box = await Hive.openBox('testCache');
    _cache = HiveDatasouce(box);
    cache = LocalDatasouceStub();
    settings = Settings(settingsBox);
    repo = TicketRepository(api, cache, settings);
    repoHive = TicketRepository(api, _cache, settings);
  });

  test('should return true on when no error occurr on api and cache', () async {
    // arange
    api.shouldFail = false;
    await repo.fetch();
    // act
    final response = await repo.insert(tk);
    expect(response, right(true));
  });

  test('should pass down failure when some error occurr only with cache', () async {
    // arange
    api.shouldFail = false;
    cache.shouldFail = true;
    cache.failure = EmptyResponseFromCache();
    // act
    final response = await repo.insert(tk);
    expect(response, left(EmptyResponseFromCache()));
  });

  test('should pass down any failures from api datasource', () async {
    // arange
    cache.shouldFail = false;
    api.shouldFail = true;
    api.failure = DatabaseError();
    // act
    final response = await repo.insert(tk);
    expect(response, left(DatabaseError()));
  });

  test('should save successful api insert on cache', () async {
    // arange
    api.shouldFail = false;
    await repoHive.fetch();
    // act
    final response = await repoHive.insert(tk);
    final cacheList = await box.get(Endpoint.tickets.name);
    expect(response, right(true));
    expect(cacheList, ticketListStub);
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
