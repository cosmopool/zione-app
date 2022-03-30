import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/usecase/i_usecase.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_ticket_repository.dart';


class FetchTicketsUsecase implements IUsecaseNoInput<List<Map>> {
  final ITicketRepository repository;
  FetchTicketsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Map>>> call() async {
    return await repository.fetch();
  }
}
