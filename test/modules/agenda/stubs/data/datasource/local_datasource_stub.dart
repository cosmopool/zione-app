import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/utils/enums.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/i_local_datasource.dart';

import '../../appointment_list_stub.dart';
import '../../ticket_list_stubs.dart';

class LocalDatasouceStub implements ILocalDatasource {
  bool shouldFail = false;
  Failure failure = ServerSideFailure();

  Either<Failure, bool> _remoteResponse(Map content) {
      return shouldFail ? left(failure) : right(true);
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
      return shouldFail ? left(failure) : right(ticketListStub);
    } else if (endpoint == Endpoint.appointments) {
      return shouldFail ? left(failure) : right(appointmentListStub);
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

  @override
  Future<void> postContentList(Endpoint endpoint, List<Map> content) async {
  }
}
