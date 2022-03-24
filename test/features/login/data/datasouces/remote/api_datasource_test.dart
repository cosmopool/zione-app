import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/login/core/errors/api_errors.dart';
import 'package:zione/app/modules/login/core/utils/constants.dart';
import 'package:zione/app/modules/login/data/datasources/remote/api_datasource.dart';
import 'package:zione/app/modules/login/data/datasources/remote/i_api_datasource.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';

void main() async {
  const tokenPart = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9";
  final user = UserEntity(username: "kaio", password: "kaio123");
  late IApiAuthDatasource api;

  setUp(() async {
    host = "0.0.0.0";
    port = "80";
    api = ApiAuthDatasource(uriMethod: Uri.http);
  });

  test('should return token on valid credentials', () async {
    late String result;
    final res = await api(user.credentials());
    res.fold((l) => null, (r) => result = r);

    expect(result, contains(tokenPart));
  });

  test('should return true when no errors occurr on saving token', () async {
    final res = await api({"username": "kaio", "password": "wrongpass"});
    expect(res, Left(WrongCredentials()));
  });

  test('should return MissingFieldError when missing username', () async {
    final res = await api({"password": "kaio123"});
    expect(res, Left(MissingFieldError()));
  });

  test('should return MissingFieldError when missing password', () async {
    final res = await api({"username": "kaio"});
    expect(res, Left(MissingFieldError()));
  });

  /* test('should return token on successful response', () async {}); */
  /**/
  /* test('should return EmptyResponseFromCache when no token is in cache', () async {}); */
  /**/
  /* test('should clear cache when call clearToken method', () async {}); */
}
