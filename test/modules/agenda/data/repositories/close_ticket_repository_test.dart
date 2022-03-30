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
import '../../stubs/data/datasource/settings_stub.dart';
import '../../stubs/ticket_list_stubs.dart';

void main() async {
  final api = RemoteDatasouceStub();
  final cache = LocalDatasouceStub();
  final settings = SettingsStub();
  final repo = TicketRepository(api, cache, settings);
  final tk = TicketEntity.fromMap(ticketListStub[0]);

  test('should return true on when no error occurr on api and cache', () async {
    // arange
    api.shouldFail = false;
    await repo.fetch();
    // act
    final response = await repo.close(tk);
    expect(response, right(true));
  });

  test('should pass down failure when some error occurr only with cache', () async {
    // arange
    api.shouldFail = false;
    cache.shouldFail = true;
    cache.failure = EmptyResponseFromCache();
    // act
    final response = await repo.close(tk);
    expect(response, left(EmptyResponseFromCache()));
  });

  test('should pass down any failures from api datasource', () async {
    // arange
    cache.shouldFail = false;
    api.shouldFail = true;
    api.failure = DatabaseError();
    // act
    final response = await repo.close(tk);
    expect(response, left(DatabaseError()));
  });

  test('should save successful api close on cache', () async {
    // arange
    await setUpTestHive();
    final settingsBox = await Hive.openBox('testSettings');
    final box = await Hive.openBox('testCache');
    final _cache = HiveDatasouce(box);
    final _settings = Settings(settingsBox);
    final _repo = TicketRepository(api, _cache, _settings);
    api.shouldFail = false;
    await _repo.fetch();
    // act
    final response = await _repo.close(tk);
    final cacheList = await box.get(Endpoint.tickets.name);
    expect(response, right(true));
    expect(cacheList, ticketListStub);
  });
}
