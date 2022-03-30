import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/usecase/i_usecase.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_appointment_repository.dart';


class InsertAppointmentUsecase implements IUsecase<dynamic, AppointmentEntity> {
  final IAppointmentRepository repository;
  InsertAppointmentUsecase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(AppointmentEntity tk) async {
    return await repository.insert(tk);
  }
}
