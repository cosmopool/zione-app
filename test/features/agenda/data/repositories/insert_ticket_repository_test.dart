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
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';

import '../../stubs/data/datasource/remote_datasource_stub.dart';
import '../../stubs/ticket_list_stubs.dart';

void main() async {
  late Box box;
  late Box settingsBox;
  late ISettings settings;
  late TicketRepository repo;
  late ILocalDatasource cache;
  final api = RemoteDatasouceStub();
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
    tk['clientName'] = "Success";
    await repo.fetch();
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.insert(_tk);
    expect(response, right(true));
  });

  test('should return CouldNotFinishRequest on server response status == error', () async {
    tk['clientName'] = "Error";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.insert(_tk);
    expect(response, left(ServerSideFailure()));
  });

  test('should return NoConnectionWithServer on socket exception', () async {
    tk['clientName'] = "NoConnection";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.insert(_tk);
    expect(response, left(NoConnectionWithServer()));
  });

  test('should return ServerSideFailure on generic error', () async {
    tk['clientName'] = "ServerSide";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.insert(_tk);
    expect(response, left(ServerSideFailure()));
  });

  test('should save successful api insert on cache', () async {
    tk['clientName'] = "Success";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.insert(_tk);
    final cacheList = await box.get(Endpoint.tickets.name);
    expect(response, right(true));
    expect(cacheList, [_tk.toMap()]);
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
