import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/agenda/data/mappers/agenda_mapper.dart';
import 'package:zione/app/modules/agenda/data/repositories/agenda_repository.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/cache_errors.dart';

import '../../stubs/data/datasource/local_datasource_stub.dart';
import '../../stubs/data/datasource/remote_datasource_stub.dart';

void main() async {
  late Box box;
  late AgendaRepository repo;
  late AgendaRepository repoHive;
  late LocalDatasouceStub cache;
  late HiveDatasouce cacheHive;
  final api = RemoteDatasouceStub();

  setUp(() async {
    await setUpTestHive();
    box = await Hive.openBox('testCache');
    cacheHive = HiveDatasouce(box);
    cache = LocalDatasouceStub();
    repo = AgendaRepository(api, cache);
    repoHive = AgendaRepository(api, cacheHive);
  });

  final entry = AgendaEntity(
    id: 1,
    date: "2021-01-25",
    time: "10:00",
    duration: "01:00",
    ticketId: 2,
    isFinished: false,
    clientName: "Nicodemos Biancato",
    clientPhone: "4199955566",
    clientAddress: "instalar as cameras na casa da frente",
    serviceType: "instalacao",
    description:
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    ticketIsFinished: false,
  );

  test('should return true on when no error occurr on api and cache', () async {
    api.shouldFail = false;
    cache.shouldFail = false;
    final response = await repo.insert(entry);
    expect(response, right(true));
  });

  test('should pass down any failures from api datasource', () async {
    api.shouldFail = true;
    api.failure = DatabaseError();
    final response = await repo.insert(entry);
    expect(response, left(DatabaseError()));
  });

  test('should pass down failure when some error occurr only with cache', () async {
    api.shouldFail = false;
    cache.shouldFail = true;
    cache.failure = EmptyResponseFromCache();
    final response = await repo.insert(entry);
    expect(response, left(EmptyResponseFromCache()));
  });

  test('should save appointment separately on successful api insert on cache', () async {
    // arrange
    api.shouldFail = false;
    // act
    final response = await repoHive.insert(entry);
    final ap = AgendaMapper.toAppointment(entry);
    final cacheList = await box.get(ap.endpoint.name);
    expect(response, right(true));
    expect(cacheList, [ap.toMap()]);
  });
  
  test('should save ticket separately on successful api insert on cache', () async {
    // arrange
    api.shouldFail = false;
    // act
    final response = await repoHive.insert(entry);
    final tk = AgendaMapper.toTicket(entry);
    final cacheList = await box.get(tk.endpoint.name);
    expect(response, right(true));
    expect(cacheList, [tk.toMap()]);
  });
  
  tearDown(() async {
    await tearDownTestHive();
  });
}
