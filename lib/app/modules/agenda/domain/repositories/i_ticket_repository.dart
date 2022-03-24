
import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

abstract class ITicketRepository<bool, TicketEntity> {
  Future<Either<Failure, List<Map>>> fetch();
  Future<Either<Failure, bool>> insert(TicketEntity tk);
  Future<Either<Failure, bool>> edit(TicketEntity tk);
  Future<Either<Failure, bool>> delete(TicketEntity tk);
  Future<Either<Failure, bool>> close(TicketEntity tk);
}
