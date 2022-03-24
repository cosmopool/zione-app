import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

abstract class ILocalAuthDatasource {
  Future<Either<Failure, bool>> saveToken(String token);
  Future<Either<Failure, String>> getToken();
  Future<void> clearToken();
}
