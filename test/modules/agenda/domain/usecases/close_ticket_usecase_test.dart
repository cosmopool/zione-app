import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/domain/usecases/close_ticket_usecase.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

import '../../mocks/ticket_repository_mock.dart';

void main() async {
  final repo = TicketRepositoryMock();
  final usecase = CloseTicketUsecase(repo);

  final tk = TicketEntity(
    clientName: "Gustavo",
    clientPhone: "4188",
    clientAddress: "Rua Ameixas",
    serviceType: "Instalacao",
    description: "Something",
  );

  test('should call repository', () async {
    repo.shouldFail = false;
    final result = await usecase(tk);
    expect(result.runtimeType, Right<Failure, bool>);
  });

  test('should get false from repository when some error has occured with backend', () async {
    repo.shouldFail = true;
    final result = await usecase(tk);
    expect(result, Left(ServerSideFailure()));
  });

  test('should get true from repository when given valid ticket entity input', () async {
    repo.shouldFail = false;
    final result = await usecase(tk);
    expect(result, const Right(true));
  });
}
