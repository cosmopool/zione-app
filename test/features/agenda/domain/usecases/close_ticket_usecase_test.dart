import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_ticket_repository.dart';
import 'package:zione/features/agenda/domain/usecases/close_ticket_usecase.dart';

import '../../mocks/ticket_repository_mock.dart';

void main() async {
  late final CloseTicketUsecase usecase; 
  late final ITicketRepository repository;

  setUp(() {
    repository = TicketRepositoryMock();
    usecase = CloseTicketUsecase(repository);
  });

  test('should call repository', () async {
    final tk = TicketEntity(clientName: "Gustavo", clientPhone: "4188", clientAddress: "Rua Ameixas", serviceType: "Instalacao", description: "Something");
    final result = await usecase(tk);
    expect(result.runtimeType, Right<Failure, bool>);
  });
  /* test('should get false from repository when some error has occured with backend', () async {}); */
  /* test('should get true from repository when given valid ticket entity input', () async {}); */
}
