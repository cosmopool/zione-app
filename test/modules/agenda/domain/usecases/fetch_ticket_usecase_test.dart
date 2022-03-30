import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_tickets_usecase.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

import '../../mocks/ticket_repository_mock.dart';
import '../../stubs/ticket_list_stubs.dart';


void main() async {
  final repo = TicketRepositoryMock();
  final usecase = FetchTicketsUsecase(repo);

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

  test('should get list of tickets when no errors occurr', () async {
    repo.shouldFail = false;
    final result = await usecase();
    expect(result, Right(ticketListStub));
  });
}
