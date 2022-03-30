import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/app/modules/core/errors/cache_errors.dart';
import 'package:zione/app/modules/login/data/datasources/local/hive_datasouce.dart';

import '../../../stub/datasource_stub.dart';

void main() async {
  final token = ApiAuthDatasourceStub().token;
  late String boxKey;
  late Box box;
  late HiveAuthDatasource cache;

  setUp(() async {
    await setUpTestHive();
    box = await Hive.openBox('testAuth');
    cache = HiveAuthDatasource(box);
    boxKey = cache.boxKey;
  });

  test('should return true when no errors occurr on saving token', () async {
    final res = await cache.saveToken(token);
    expect(res, const Right(true));
  });

  test('should return token on successful response', () async {
    // setup token
    await box.put(boxKey, token);
    final res = await cache.getToken();

    expect(res, Right(token));
  });

  test('should return EmptyResponseFromCache when no token is in cache', () async {
    await box.clear();
    final res = await cache.getToken();

    expect(res, Left(EmptyResponseFromCache()));
  });

  test('should clear cache when call clearToken method', () async {
    const msg = "freeeezaaaaaa, pq vc matou o kuririn";
    // setup token
    await box.put(boxKey, token);
    await cache.clearToken();
    final res = await box.get(boxKey, defaultValue: msg);

    expect(res, msg);
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
