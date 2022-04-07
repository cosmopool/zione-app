import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_appointment_repository.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_appointments.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

import '../agenda_list_stub.dart';


class FetchAppointmentsUsecaseStub extends FetchAppointmentsUsecase {
  bool shouldFail = false;
  Failure failure = ServerSideFailure();

  FetchAppointmentsUsecaseStub(IAppointmentRepository repository) : super(repository);

  @override
  Future<Either<Failure, List<Map>>> call() async {
    return shouldFail ? Left(failure) : Right(appointmentListStub);
  }
}
