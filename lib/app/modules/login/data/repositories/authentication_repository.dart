import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/login/data/datasources/local/i_local_datasouce.dart';
import 'package:zione/app/modules/login/data/datasources/remote/i_api_datasource.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';
import 'package:zione/app/modules/login/domain/repositories/i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final IApiAuthDatasource _api;
  final ILocalAuthDatasource _cache;
  AuthenticationRepository(this._api, this._cache);
  
  @override
  Future<Either<Failure, String>> call(UserEntity user) async {
    late String token;
    late Failure failure;

    final res = await _api(user.credentials());
    res.fold((l) => failure = l, (r) => token = r);

    if (res.isRight()) {
      await _cache.saveToken(token);
      return Right(token);
    } else {
      await _cache.clearToken();
      return Left(failure);
    }
  }
}
