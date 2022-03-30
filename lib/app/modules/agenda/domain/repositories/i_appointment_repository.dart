import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

abstract class IAppointmentRepository<bool, AppointmentEntity> {
  Future<Either<Failure, List<Map>>> fetch();
  Future<Either<Failure, bool>> insert(AppointmentEntity tk);
  Future<Either<Failure, bool>> edit(AppointmentEntity tk);
  Future<Either<Failure, bool>> delete(AppointmentEntity tk);
  Future<Either<Failure, bool>> close(AppointmentEntity tk);
}
