import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_agenda_repository.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/usecase/i_usecase.dart';


class InsertAgendaUsecase implements IUsecase<dynamic, AgendaEntity> {
  final IAgendaRepository repository;
  InsertAgendaUsecase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(AgendaEntity entry) async {
    return await repository.insert(entry);
  }
}
