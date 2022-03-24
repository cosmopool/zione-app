import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:zione/app/modules/core/errors/cache_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/login/data/datasources/local/i_local_datasouce.dart';

class HiveAuthDatasource implements ILocalAuthDatasource {
  late Box _box;
  final String boxName = "settings";
  final String boxKey = "authenticationToken";
  HiveAuthDatasource(this._box);

  @override
  Future<Either<Failure, bool>> saveToken(String token) async {
    await _box.put(boxKey, token);
    final res = _box.get(boxKey, defaultValue: "");
    if (res == "") {
      return Left(NotAbleToSaveContent());
    } else {
      return const Right(true);
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    final res = _box.get(boxKey, defaultValue: "");
    if (res == "") {
      return Left(EmptyResponseFromCache());
    } else {
      return Right(res);
    }
  }

  @override
  Future<void> clearToken() async {
    await _box.clear();
  }
}
