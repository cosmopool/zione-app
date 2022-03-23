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
  Future<Either<Failure, bool>> delete(TicketEntity tk) async {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> edit(TicketEntity tk) async {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> insert(TicketEntity tk) async {
    // TODO: implement insert
    throw UnimplementedError();
  }
}
