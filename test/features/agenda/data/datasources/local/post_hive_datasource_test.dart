import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/local/hive_datasouce.dart';
import 'package:zione/features/agenda/data/datasources/local/i_local_datasource.dart';

import '../../../stubs/ticket_list_stubs.dart';

void main() async {
  const tkEndpoint = Endpoint.tickets;
  late Box box;
  late ILocalDatasource cache;

  setUp(() async {
    await setUpTestHive();
    box = await Hive.openBox<List<Map>>('testBox');
    cache = HiveDatasouce(box);
  });

  test('should save a ticket when given valid input', () async {
    await box.put('tickets', [ticketListStub[1], ticketListStub[2]]);
    await cache.postContent(tkEndpoint, ticketListStub[0]);
    final List<Map> res = await box.get('tickets');
    expect(res.length, 3);
  });

  test('should save a ticket in empty boxKey', () async {
    final List<Map> first = await box.get('tickets', defaultValue: [{}]);
    await cache.postContent(tkEndpoint, ticketListStub[0]);
    final List<Map> res = await box.get('tickets');
    expect(res, [ticketListStub[0]]);
    expect(first, [{}]);
  });

  test('should return true when given valid input', () async {
    final res = await cache.postContent(tkEndpoint, ticketListStub[0]);
    expect(res, right(true));
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
