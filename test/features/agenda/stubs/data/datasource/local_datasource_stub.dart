import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/local/i_local_datasource.dart';

import '../../ticket_list_stubs.dart';

class LocalDatasouceStub implements ILocalDatasource {
  bool successfulFetch = true;

  @override
  Future<Either<Failure, bool>> closeContent(endpoint, Map content) async {
    if (content['clientName'] == "Success" || content['date'] == "Success")  return right(true);
    if (content['clientName'] == "NoConnection" || content['date'] == "NoConnection")  throw const SocketException("Msg");
    if (content['clientName'] == "ServerSide" || content['date'] == "ServerSide")  throw Exception("Msg");
    if (content['clientName'] == "Error" || content['date'] == "Error") return left(ServerSideFailure());
    return left(ServerSideFailure());
  }

  @override
  Future<Either<Failure, bool>> deleteContent(Endpoint endpoint, Map content) async {
    // TODO: implement deleteContent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Map>>> fetchContent(Endpoint endpoint) async {
    if (endpoint == Endpoint.tickets) {
      return successfulFetch ? right(ticketListStub) : left(ServerSideFailure());
    } else {
      return left(ServerSideFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> postContent(Endpoint endpoint, Map content) async {
    // TODO: implement postContent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateContent(Endpoint endpoint, Map content) async {
    // TODO: implement updateContent
    throw UnimplementedError();
  }

  @override
  Future<void> postContentList(Endpoint endpoint, List<Map> content) async {
  }
}
