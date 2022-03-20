import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/ui/widgets/entry_form/components/intpu_text_ttt.dart';

void main() {
  const Map<String, dynamic> nicoEntry = {
    "id": 1,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "4199955566",
    "clientAddress": "instalar as cameras na casa da frente",
    "serviceType": "instalacao",
    "description":
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    "isFinished": false
  };

  test('Should update clientName with new value', () {
    final TicketEntity entry = TicketEntity.fromMap(nicoEntry);
    buildInput("Test". TextInputType.text, entry.clientName);

    expect(entry.id, equals(1));
  });

}
