import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/i_datasource.dart';

class DatasouceStub implements IDatasource {
  @override
  Future<Either<Failure, bool>> closeContent(endpoint, Map content) async {
    if (content['clientName'] == "Success" || content['date'] == "Success")  return right(true);
    if (content['clientName'] == "NoConnection" || content['date'] == "NoConnection")  throw const SocketException("Msg");
    if (content['clientName'] == "ServerSide" || content['date'] == "ServerSide")  throw Exception("Msg");
    if (content['clientName'] == "Error" || content['date'] == "Error") return left(ServerSideFailure());
    return left(ServerSideFailure());
  }

  @override
  Future<Either<Failure, bool>> deleteContent(Endpoint endpoint, Map content) {
    // TODO: implement deleteContent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Map>>> fetchContent(Endpoint endpoint) {
    // TODO: implement fetchContent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> postContent(Endpoint endpoint, Map content) {
    // TODO: implement postContent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateContent(Endpoint endpoint, Map content) {
    // TODO: implement updateContent
    throw UnimplementedError();
  }
}
