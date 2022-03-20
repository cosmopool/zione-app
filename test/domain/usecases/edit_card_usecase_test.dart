import 'package:flutter_test/flutter_test.dart';
import 'package:zione/features/agenda/data/datasources/edit_card_datasource.dart';

import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/domain/usecases/i_edit_card_usecase.dart';
import 'package:zione/features/agenda/infra/repositories/edit_card_repository.dart';

import '../../stubs/api_datasource.dart';


void main() {
  const Map<String, dynamic> ticketEntry = {
    "id": 1,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "4199955566",
    "clientAddress": "instalar as cameras na casa da frente",
    "serviceType": "instalacao",
    "description": "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    "isFinished": false
  };

  final datasource = EditCardDataSource(ApiServerDatasourceTest());
  final repository = EditCardRepository(datasource);
  final usecase = EditCardUsecase(repository);

  test('Should return true when given valid input', () async {
    final TicketEntity entry = TicketEntity.fromMap(ticketEntry);
    final res = await usecase(entry);

    expect(res, true);
  });

}
