import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/login/domain/repositories/i_authentication_repository.dart';

class AuthenticationRepositoryStub implements IAuthenticationRepository {
  Failure failure = ServerSideFailure();
  bool responseStatus = true;
  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY0NzM3Njg1NiwianRpIjoiN2Y4MmQ2MDktNmI3ZS00ZWNmLTk0OTktOWVlZjc5MDg2ZmI4IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImthaW8iLCJuYmYiOjE2NDczNzY4NTYsImV4cCI6ODgwNDczNzY4NTZ9.g552C26lKVwBGADxrrwAkOO6k8d7XW_L-r2vz3IPyp8";

  @override
  Future<Either<Failure, String>> call(UserEntity user) async {
    if (responseStatus == true) {
      return Right(token);
    } else {
      return Left(failure);
    }
  }
}
