import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/usecase/i_usecase.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';
import 'package:zione/app/modules/login/domain/repositories/i_authentication_repository.dart';

class LoginUsecase implements IUsecase<bool, UserEntity> {
  final IAuthenticationRepository _repo;
  LoginUsecase(this._repo);

  @override
  Future<Either<Failure, bool>> call(UserEntity user) async {
    final log = Logger('LoginUsecase');
    late Failure failure;
    late String token;

    final res = await _repo(user);
    res.fold((l) => failure = l, (r) => token = r);

    if (res.isRight()) {
      user.token = token;
      return const Right(true);
    } else {
      return Left(failure);
    }
  }
}
