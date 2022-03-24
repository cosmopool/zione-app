import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';

abstract class IAuthenticationRepository {
  Future<Either<Failure, String>> call(UserEntity user);
}
