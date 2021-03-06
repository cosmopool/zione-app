import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/app/modules/core/errors/cache_errors.dart';
import 'package:zione/app/modules/core/utils/enums.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/i_local_datasource.dart';

import '../../../stubs/ticket_list_stubs.dart';

void main() async {
  const tkEndpoint = Endpoint.tickets;
  late Box box;
  late ILocalDatasource cache;

  setUp(() async {
    await setUpTestHive();
    box = await Hive.openBox('testBox');
    cache = HiveDatasouce(box);
  });

  test('should delete a ticket when given valid input', () async {
    final lengthBefore = ticketListStub.length;
    await box.put('tickets', ticketListStub);
    await cache.deleteContent(tkEndpoint, ticketListStub[0]);
    final List<Map> res = await box.get('tickets');
    expect(res == [{}], false);
    expect(res.length != lengthBefore, true);
  });

  test('should return true when given valid input', () async {
    await box.put('tickets', ticketListStub);
    final res = await cache.deleteContent(tkEndpoint, ticketListStub[0]);
    expect(res, right(true));
  });

  test('should return EntryNotFound when given invalid ticket', () async {
    await box.put('tickets', ticketListStub);
    final tk = {'id': "1"};
    final res = await cache.deleteContent(tkEndpoint, tk);
    expect(res, left(EntryNotFound("{id: $id}")));
  });

  test('should return EntryNotFound when given valid ticket that is not on the list', () async {
    await box.put('tickets', ticketListStub);
    final tk = {'id': -1};
    final res = await cache.deleteContent(tkEndpoint, tk);
    expect(res, left(EntryNotFound("{id: $id}")));
  });

  test('should return EmptyResponseFromCache  on empty box', () async {
    final res = await cache.deleteContent(Endpoint.login, ticketListStub[0]);
    expect(res, left(EmptyResponseFromCache()));
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
