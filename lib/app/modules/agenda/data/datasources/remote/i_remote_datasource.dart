import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

abstract class IRemoteDatasource {
  Future<Either<Failure, List<Map>>> fetchContent(Endpoint endpoint);
  Future<Either<Failure, bool>> postContent(Endpoint endpoint, Map content);
  Future<Either<Failure, bool>> updateContent(Endpoint endpoint, Map content);
  Future<Either<Failure, bool>> closeContent(Endpoint endpoint, Map content);
  Future<Either<Failure, bool>> deleteContent(Endpoint endpoint, Map content);
}
