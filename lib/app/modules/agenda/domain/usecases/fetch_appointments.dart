import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_appointment_repository.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/usecase/i_usecase.dart';


class FetchAppointmentsUsecase implements IUsecaseNoInput<List<Map>> {
  final IAppointmentRepository repository;
  FetchAppointmentsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Map>>> call() async {
    return await repository.fetch();
  }
}
