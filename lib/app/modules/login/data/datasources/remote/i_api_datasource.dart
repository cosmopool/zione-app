import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

abstract class IApiAuthDatasource {
  Future<Either<Failure, String>> call(Map credentials);
}
