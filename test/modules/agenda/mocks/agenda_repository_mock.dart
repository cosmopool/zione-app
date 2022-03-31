import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_agenda_repository.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

class AgendaRepositoryMock
    implements IAgendaRepository<bool, AgendaEntity> {
  bool shouldFail = false;
  Failure responseFailure = ServerSideFailure();

  @override
  Future<Either<Failure, bool>> insert(AgendaEntity entry) async {
    return shouldFail ? left(responseFailure) : right(true);
  }
}
