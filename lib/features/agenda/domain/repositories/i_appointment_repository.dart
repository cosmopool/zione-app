import 'package:zione/features/agenda/domain/entities/appointment.dart';

abstract class IAppointmentRepository {
  Future<bool> insert(Appointment ap);
  Future<bool> edit(Appointment ap);
  Future<bool> delete(Appointment ap);
  Future<bool> close(Appointment ap);
  Future<bool> reschedule(Appointment ap);
}
