import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/usecase/i_usecase.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_ticket_repository.dart';


class CloseTicketUsecase implements IUsecase<dynamic, TicketEntity> {
  final ITicketRepository repository;
  CloseTicketUsecase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(TicketEntity tk) async {
    return await repository.close(tk);
  }
}
