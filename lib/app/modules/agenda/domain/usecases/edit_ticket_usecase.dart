import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/usecase/i_usecase.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_ticket_repository.dart';


class EditTicketUsecase implements IUsecase<dynamic, TicketEntity> {
  final ITicketRepository repository;
  EditTicketUsecase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(TicketEntity tk) async {
    return await repository.edit(tk);
  }
}
