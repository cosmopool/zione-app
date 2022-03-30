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
    box = await Hive.openBox<List<Map>>('testCache');
    cache = HiveDatasouce(box);
  });

  test('should update a ticket when given valid input', () async {
    await box.put('tickets', ticketListStub);
    Map tk = ticketListStub[0];
    tk['clientName'] = "Mossoroca";
    await cache.updateContent(tkEndpoint, tk);
    final List<Map> res = await box.get('tickets');
    expect(res[0], tk);
  });

  test('should return true when given valid input', () async {
    await box.put('tickets', ticketListStub);
    Map tk = ticketListStub[0];
    tk['clientName'] = "Mossoroca";
    final res = await cache.updateContent(tkEndpoint, ticketListStub[0]);
    expect(res, right(true));
  });

  test('should return EntryNotFound when given valid ticket that is not on the list', () async {
    await box.put('tickets', ticketListStub);
    final tk = {'id': 109};
    final res = await cache.updateContent(tkEndpoint, tk);
    expect(res, left(EntryNotFound("{id: $id}")));
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
