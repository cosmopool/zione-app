import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

abstract class IAgendaRepository<bool, AgendaEntity> {
  Future<Either<Failure, bool>> insert(AgendaEntity tk);
}
