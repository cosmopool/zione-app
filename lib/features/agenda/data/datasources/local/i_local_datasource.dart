import 'package:dartz/dartz.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/core/utils/enums.dart';

abstract class ILocalDatasource {
  Future<Either<Failure, List<Map>>> fetchContent(Endpoint endpoint);
  Future<Either<Failure, bool>> postContent(Endpoint endpoint, Map content);
  Future<Either<Failure, bool>> updateContent(Endpoint endpoint, Map content);
  Future<Either<Failure, bool>> closeContent(Endpoint endpoint, Map content);
  Future<Either<Failure, bool>> deleteContent(Endpoint endpoint, Map content);
  Future<void> postContentList(Endpoint endpoint, List<Map> content);
}
