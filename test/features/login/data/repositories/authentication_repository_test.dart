import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:zione/app/modules/login/core/errors/api_errors.dart';
import 'package:zione/app/modules/login/core/errors/cache_errors.dart';
import 'package:zione/app/modules/login/data/datasources/local/hive_datasouce.dart';
import 'package:zione/app/modules/login/data/repositories/authentication_repository.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';

import '../../stub/datasource_stub.dart';

void main() async {
  final dataStub = ApiAuthDatasourceStub();
  late AuthenticationRepository authenticate;
  late Box box;
  late HiveAuthDatasource cache;

  setUp(() async {
    await setUpTestHive();
    box = await Hive.openBox('testAuth');
    cache = HiveAuthDatasource(box);
    authenticate = AuthenticationRepository(dataStub, cache);
  });

  test('should return true when no errors occurr', () async {
    // setup entity
    final user = UserEntity(username: "kaio", password: "kaio123");
    // sending request
    late String tokenRes;
    final res = await authenticate(user);
    res.fold((l) => null, (r) => tokenRes = r);

    expect(tokenRes.runtimeType, equals(String));
  });

  test('should have token on success response', () async {
    // setup entity
    final user = UserEntity(username: "kaio", password: "kaio123");
    // sending request
    final res = await authenticate(user);

    expect(res, Right(dataStub.token));
  });

  test('should pass down token from repository', () async {
    // setup datasource
    dataStub.token = "some_token";
    // setup entity
    final user = UserEntity(username: "kaio", password: "kaio123");
    // sending request
    final res = await authenticate(user);

    expect(res, Right(dataStub.token));
  });

  test('should pass down Failure from repository 1', () async {
    // setup datasource
    dataStub.responseStatus = false;
    dataStub.failure = EntryNotFound("");
    // setup entity
    final user = UserEntity(username: "kaio", password: "kaio123");
    // sending request
    final res = await authenticate(user);

    expect(res, Left(EntryNotFound("")));
  });

  test('should pass down Failure from repository 2', () async {
    // setup failure
    final failure = NoConnectionWithServer();
    // setup datasource
    dataStub.responseStatus = false;
    dataStub.failure = failure;
    // setup entity
    final user = UserEntity(username: "kaio", password: "kaio123");
    // sending request
    final res = await authenticate(user);

    expect(res, Left(failure));
  });

  test('should on success save token in cache', () async {
    // setup datasource
    dataStub.responseStatus = true;
    // setup entity
    final user = UserEntity(username: "kaio", password: "kaio123");
    // sending request
    final res = await authenticate(user);
    // get token from cache
    final cacheToken = box.get(cache.boxKey, defaultValue: "emtpy_cache");

    expect(res, Right(cacheToken));
  });

  test('should on failure clear token in cache', () async {
    // setup datasource
    dataStub.responseStatus = false;
    dataStub.token = "obscure_fsociety_token";
    // setup cachedatasource
    await box.put(cache.boxKey, dataStub.token);
    // setup entity
    final user = UserEntity(username: "kaio", password: "kaio123");
    // sending request
    final res = await authenticate(user);
    // get token from cache
    final cacheToken = await box.get(cache.boxKey, defaultValue: "emtpy_cache");

    expect(res.isLeft(), true);
    expect(cacheToken, "emtpy_cache");
  });

  tearDown(() async {
    await tearDownTestHive();
  });
}
