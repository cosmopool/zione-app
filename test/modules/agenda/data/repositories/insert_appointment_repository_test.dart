import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/agenda/data/mappers/appointment_mapper.dart';
import 'package:zione/app/modules/agenda/data/repositories/appointment_repository.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/cache_errors.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

import '../../stubs/data/datasource/local_datasource_stub.dart';
import '../../stubs/data/datasource/remote_datasource_stub.dart';
import '../../stubs/data/datasource/settings_stub.dart';

void main() async {
  final api = RemoteDatasouceStub();
  final cache = LocalDatasouceStub();
  final settings = SettingsStub();
  final repo = AppointmentRepository(api, cache, settings);

  final ap = AppointmentEntity(
    id: 1,
    date: "2021-01-25",
    time: "10:00",
    duration: "01:00",
    ticketId: 2,
    isFinished: false,
  );

  test('should return true on when no error occurr on api and cache', () async {
    api.shouldFail = false;
    await repo.fetch();
    final response = await repo.insert(ap);
    expect(response, right(true));
  });

  test('should pass down any failures from api datasource', () async {
    api.shouldFail = true;
    api.failure = DatabaseError();
    final response = await repo.insert(ap);
    expect(response, left(DatabaseError()));
  });

  test('should pass down failure when some error occurr only with cache', () async {
    api.shouldFail = false;
    cache.shouldFail = true;
    cache.failure = EmptyResponseFromCache();
    final response = await repo.insert(ap);
    expect(response, left(EmptyResponseFromCache()));
  });

  test('should save successful api insert on cache', () async {
    await setUpTestHive();
    final settingsBox = await Hive.openBox('testSettings');
    final box = await Hive.openBox('testCache');
    final _cache = HiveDatasouce(box);
    final _settings = Settings(settingsBox);
    final _repo = AppointmentRepository(api, _cache, _settings);
    api.shouldFail = false;

    final response = await _repo.insert(ap);
    final cacheList = await box.get(Endpoint.appointments.name);
    expect(response, right(true));
    expect(cacheList, [AppointmentMapper.toMap(ap)]);
    await tearDownTestHive();
  });
}
