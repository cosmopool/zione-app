import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/agenda/domain/usecases/insert_agenda_entry_usecase.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

import '../../mocks/agenda_repository_mock.dart';

void main() async {
  final repo = AgendaRepositoryMock();
  final usecase = InsertAgendaUsecase(repo);

  final ap = AgendaEntity(
    id: 1,
    date: "2021-01-25",
    time: "10:00",
    duration: "01:00",
    ticketId: 2,
    isFinished: false,
    clientName: "Nicodemos Biancato",
    clientPhone: "4199955566",
    clientAddress: "instalar as cameras na casa da frente",
    serviceType: "instalacao",
    description:
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    ticketIsFinished: false,
  );

  test('should call repository', () async {
    repo.shouldFail = false;
    final result = await usecase(ap);
    expect(result.runtimeType, Right<Failure, bool>);
  });

  test('should get false from repository when some error has occured with backend', () async {
    repo.shouldFail = true;
    final result = await usecase(ap);
    expect(result, Left(ServerSideFailure()));
  });

  test('should get true from repository when given valid agenda entity input', () async {
    repo.shouldFail = false;
    final result = await usecase(ap);
    expect(result, const Right(true));
  });
}
