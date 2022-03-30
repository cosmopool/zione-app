import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_ticket_repository.dart';

import '../stubs/ticket_list_stubs.dart';

class TicketRepositoryMock implements ITicketRepository<bool, TicketEntity> {
  bool shouldFail = false;
  Failure responseFailure = ServerSideFailure();

  @override
  Future<Either<Failure, bool>> close(TicketEntity tk) async {
    return shouldFail ? left(responseFailure) : right(true);
  }

  @override
  Future<Either<Failure, bool>> delete(TicketEntity tk) async {
    return shouldFail ? left(responseFailure) : right(true);
  }

  @override
  Future<Either<Failure, bool>> edit(TicketEntity tk) async {
    return shouldFail ? left(responseFailure) : right(true);
  }

  @override
  Future<Either<Failure, List<Map>>> fetch() async {
    return shouldFail ? left(responseFailure) : right(ticketListStub);
  }

  @override
  Future<Either<Failure, bool>> insert(TicketEntity tk) async {
    return shouldFail ? left(responseFailure) : right(true);
  }
}
