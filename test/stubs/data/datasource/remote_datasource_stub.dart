import 'package:dartz/dartz.dart';
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/remote/i_remote_datasource.dart';

import '../../ticket_list_stubs.dart';

class RemoteDatasouceStub implements IRemoteDatasource {
  bool successfulFetch = true;

  Either<Failure, bool> _remoteResponse(Map content){
    if (content['clientName'] == "Success" || content['date'] == "Success")  return right(true);
    if (content['clientName'] == "NoConnection" || content['date'] == "NoConnection")  return left(NoConnectionWithServer());
    if (content['clientName'] == "ServerSide" || content['date'] == "ServerSide")  return left(ServerSideFailure());
    if (content['clientName'] == "Error" || content['date'] == "Error") return left(ServerSideFailure());
    return right(true);
  }

  @override
  Future<Either<Failure, bool>> closeContent(endpoint, Map content) async {
    return _remoteResponse(content);
  }

  @override
  Future<Either<Failure, bool>> deleteContent(Endpoint endpoint, Map content) async {
    return _remoteResponse(content);
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
    return _remoteResponse(content);
  }

  @override
  Future<Either<Failure, bool>> updateContent(Endpoint endpoint, Map content) async {
    return _remoteResponse(content);
  }
}
