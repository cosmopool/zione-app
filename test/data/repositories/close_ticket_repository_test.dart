import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/core/errors/api_errors.dart';
import 'package:zione/features/agenda/data/repositories/ticket_repository.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';

import '../../stubs/data/datasource/datasource_stub.dart';
import '../../stubs/ticket_list_stubs.dart';

void main() async {
  final api = DatasouceStub();
  final cache = DatasouceStub();
  final repo = TicketRepository(api, cache);
  Map tk = ticketListStub[0];

  test('should return true on server response status == success', () async {
    tk['clientName'] = "Success";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.close(_tk);
    expect(response, right(true));
  });

  test('should return CouldNotFinishRequest on server response status == error', () async {
    tk['clientName'] = "Error";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.close(_tk);
    expect(response, left(ServerSideFailure()));
  });

  test('should return NoConnectionWithServer on socket exception', () async {
    tk['clientName'] = "NoConnection";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.close(_tk);
    expect(response, left(NoConnectionWithServer()));
  });

  test('should return ServerSideFailure on generic error', () async {
    tk['clientName'] = "ServerSide";
    final _tk = TicketEntity.fromMap(tk);
    final response = await repo.close(_tk);
    expect(response, left(ServerSideFailure()));
  });
}
