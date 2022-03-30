import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_appointments.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

import '../../mocks/appointment_repository_mock.dart';
import '../../stubs/appointment_list_stub.dart';


void main() async {
  final repo = AppointmentRepositoryMock();
  final usecase = FetchAppointmentsUsecase(repo);

  test('should call repository', () async {
    repo.shouldFail = false;
    final result = await usecase();
    expect(result.runtimeType, Right<Failure, List<Map>>);
  });

  test('should get false from repository when some error has occured with backend', () async {
    repo.shouldFail = true;
    final result = await usecase();
    expect(result, Left(ServerSideFailure()));
  });

  test('should get list of appointments when no errors occurr', () async {
    repo.shouldFail = false;
    final result = await usecase();
    expect(result, Right(appointmentListStub));
  });
}
