import 'package:zione/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_ticket_repository.dart';

class TicketRepositoryMock implements ITicketRepository<bool, TicketEntity> {
  @override
  Future<Either<Failure, bool>> close(TicketEntity tk) async {
    return right(true);
  }

  @override
  Future<Either<Failure, bool>> delete(TicketEntity tk) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> edit(TicketEntity tk) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Map>>> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> insert(TicketEntity tk) {
    // TODO: implement insert
    throw UnimplementedError();
  }
}
