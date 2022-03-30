import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_appointment_repository.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

import '../stubs/appointment_list_stub.dart';

class AppointmentRepositoryMock
    implements IAppointmentRepository<bool, AppointmentEntity> {
  bool shouldFail = false;
  Failure responseFailure = ServerSideFailure();

  @override
  Future<Either<Failure, bool>> close(AppointmentEntity ap) async {
    return shouldFail ? left(responseFailure) : right(true);
  }

  @override
  Future<Either<Failure, bool>> delete(AppointmentEntity ap) async {
    return shouldFail ? left(responseFailure) : right(true);
  }

  @override
  Future<Either<Failure, bool>> edit(AppointmentEntity ap) async {
    return shouldFail ? left(responseFailure) : right(true);
  }

  @override
  Future<Either<Failure, List<Map>>> fetch() async {
    return shouldFail ? left(responseFailure) : right(appointmentListStub);
  }

  @override
  Future<Either<Failure, bool>> insert(AppointmentEntity ap) async {
    return shouldFail ? left(responseFailure) : right(true);
  }
}
