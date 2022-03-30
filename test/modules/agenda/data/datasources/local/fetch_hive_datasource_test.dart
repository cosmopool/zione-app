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

  test('should return list of tickets', () async {
    await box.put('tickets', ticketListStub);
    final res = await cache.fetchContent(tkEndpoint);
    expect(res, right(ticketListStub));
  });

  test('should return EmptyResponseFromCache when box is empty', () async {
    final res = await cache.fetchContent(tkEndpoint);
    expect(res, left(EmptyResponseFromCache()));
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
