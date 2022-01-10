import 'package:flutter_test/flutter_test.dart';

import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';

void main() {
  const Map<String, dynamic> nicoEntry = {
    "ticketId": 2,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "4199955566",
    "clientAddress": "instalar as cameras na casa da frente",
    "serviceType": "instalacao",
    "description":
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    "ticketIsFinished": false,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false
  };

  const Map<String, dynamic> nicoEntryEditedPhone = {
    "ticketId": 2,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "41996351984",
    "clientAddress": "instalar as cameras na casa da frente",
    "serviceType": "instalacao",
    "description":
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    "ticketIsFinished": false,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false
  };

  const Map<String, dynamic> nicoEntryEditedMulti = {
    "ticketId": 2,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "asdf",
    "clientAddress": "asdf",
    "serviceType": "asdf",
    "description": "asdf",
    "ticketIsFinished": false,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false
  };

  test('Id field should be not null, when given valid input', () {
    final AgendaEntryEntity entry = AgendaEntryEntity(nicoEntry);

    expect(entry.id, equals(1));
  });

  test('Should be instance of AgendaEntryEntity, given valid input', () {
    final AgendaEntryEntity entry = AgendaEntryEntity(nicoEntry);

    expect(entry, isInstanceOf<AgendaEntryEntity>());
  });

  test('Should return map of an instance when toMap is called', () {
    final AgendaEntryEntity entry = AgendaEntryEntity(nicoEntry);
    final Map toMap = entry.toMap();

    expect(toMap, nicoEntry);
  });

  test('Should edit (override) all given fields', () {
    final AgendaEntryEntity entry = AgendaEntryEntity(nicoEntry);
    entry.edit(nicoEntryEditedMulti);

    expect(entry.toMap(), AgendaEntryEntity(nicoEntryEditedMulti).toMap());
  });

  test('Should edit (override) only given fields', () {
    final AgendaEntryEntity entry = AgendaEntryEntity(nicoEntry);
    final Map toEdit = {"clientPhone": "41996351984"};
    entry.edit(toEdit);

    expect(entry.toMap(), AgendaEntryEntity(nicoEntryEditedPhone).toMap());
  });

  test('Should not edit (override) id field', () {
    final AgendaEntryEntity entry = AgendaEntryEntity(nicoEntry);
    final Map toEdit = {"id": 5};
    entry.edit(toEdit);

    expect(entry.id, 1);
  });
}
