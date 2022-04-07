import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zione/app/modules/agenda/data/mappers/appointment_mapper.dart';
import 'package:zione/app/modules/agenda/domain/usecases/close_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/delete_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/edit_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_appointments.dart';
import 'package:zione/app/modules/agenda/domain/usecases/insert_appointment_usecase.dart';
import 'package:zione/app/modules/agenda/ui/stores/appointment_store.dart';

import '../../stubs/appointment_list_stub.dart';

class FetchAppointmentsUsecaseStub extends Mock
    implements FetchAppointmentsUsecase {}

class InsertAppointmentUsecaseStub extends Mock
    implements InsertAppointmentUsecase {}

class DeleteAppointmentUsecaseStub extends Mock
    implements DeleteAppointmentUsecase {}

class CloseAppointmentUsecaseStub extends Mock
    implements CloseAppointmentUsecase {}

class EditAppointmentUsecaseStub extends Mock
    implements EditAppointmentUsecase {}

main() async {
  late final FetchAppointmentsUsecaseStub fetchUsecase;
  late final InsertAppointmentUsecaseStub insertUsecase;
  late final DeleteAppointmentUsecaseStub deleteUsecase;
  late final CloseAppointmentUsecaseStub closeUsecase;
  late final EditAppointmentUsecaseStub editUsecase;
  late AppointmentStore store;

  setUp(() {
    fetchUsecase = FetchAppointmentsUsecaseStub();
    insertUsecase = InsertAppointmentUsecaseStub();
    deleteUsecase = DeleteAppointmentUsecaseStub();
    closeUsecase = CloseAppointmentUsecaseStub();
    editUsecase = EditAppointmentUsecaseStub();
    store = AppointmentStore(
      fetchUsecase,
      insertUsecase,
      deleteUsecase,
      closeUsecase,
      editUsecase,
    );
  });

  test('should return a map of appointments separated by date', () {
    final list = AppointmentMapper.fromMapList(appointmentListStub);
    final byDate = store.byDate(list);
    final dates = [
      '2021-01-12',
      '2021-12-02',
      '2021-12-09',
      '2022-04-02',
      '2022-07-02',
      '2022-06-06',
      '2022-05-26',
      '2022-04-14',
      '2022-04-21',
      '2022-04-04',
      '2022-04-07',
    ];

    expect(byDate.keys, dates);
  });
}
