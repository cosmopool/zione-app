import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';
import 'package:zione/app/modules/login/domain/usecases/login_usecase.dart';

import '../../stub/repo_stub.dart';

void main() async {
  final repoStub = AuthenticationRepositoryStub();
  final signedIn = LoginUsecase(repoStub);

  test('should return true when no errors occurr', () async {
    repoStub.responseStatus = true;
    final user = UserEntity(username: "kaio", password: "kaio123");
    final res = await signedIn(user);

    expect(res, const Right(true));
  });

  test('should return have token on success response', () async {
    repoStub.responseStatus = true;
    final user = UserEntity(username: "kaio", password: "kaio123");
    final res = await signedIn(user);

    expect(res, const Right(true));
    expect(user.tokenIsSet, true);
  });

  test('should not assign any token if failure returns from repository response', () async {
    repoStub.responseStatus = true;
    final user = UserEntity(username: "kaio", password: "kaio123");
    final res = await signedIn(user);
    
    expect(res, const Right(true));
    expect(user.tokenIsSet, true);
  });

  test('should assign to user token from repository', () async {
    // setup repo
    repoStub.responseStatus = true;
    repoStub.token = "some_stub_token";

    // sending request
    final user = UserEntity(username: "kaio", password: "kaio123");
    final res = await signedIn(user);

    expect(res, const Right(true));
    expect(user.token, repoStub.token);
  });

  test('should pass down Failure from repository 1', () async {
    // setup repo
    repoStub.responseStatus = false;
    repoStub.failure = NoConnectionWithServer();

    // sending request
    final user = UserEntity(username: "kaio", password: "kaio123");
    final res = await signedIn(user);

    expect(res, Left(NoConnectionWithServer()));
  });

  test('should pass down Failure from repository 2', () async {
    // setup repo
    repoStub.responseStatus = false;
    repoStub.failure = ServerSideFailure();

    // sending request
    final user = UserEntity(username: "kaio", password: "kaio123");
    final res = await signedIn(user);

    expect(res, Left(ServerSideFailure()));
  });
}
