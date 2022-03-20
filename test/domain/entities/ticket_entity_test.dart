import 'package:flutter_test/flutter_test.dart';

import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';

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

  const Map<String, dynamic> nicoEntryEditedPhone = {
    "id": 1,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "41996351984",
    "clientAddress": "instalar as cameras na casa da frente",
    "serviceType": "instalacao",
    "description":
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    "isFinished": false
  };

  const Map<String, dynamic> nicoEntryEditedMulti = {
    "id": 1,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "asdf",
    "clientAddress": "asdf",
    "serviceType": "asdf",
    "description": "asdf",
    "isFinished": false
  };

  test('Id field should be not null, when given valid input', () {
    final TicketEntity entry = TicketEntity.fromMap(nicoEntry);

    expect(entry.id, equals(1));
  });

  test('Should be instance of TicketEntity, given valid input', () {
    final TicketEntity entry = TicketEntity.fromMap(nicoEntry);

    expect(entry, isInstanceOf<TicketEntity>());
  });

  test('Should return map of an instance when toMap is called', () {
    final TicketEntity entry = TicketEntity.fromMap(nicoEntry);
    final Map toMap = entry.toMap();

    expect(toMap, nicoEntry);
  });

  test('Should edit (override) all given fields', () {
    final TicketEntity entry = TicketEntity.fromMap(nicoEntry);
    entry.edit(nicoEntryEditedMulti);

    expect(entry.toMap(), TicketEntity.fromMap(nicoEntryEditedMulti).toMap());
  });

  test('Should edit (override) only given fields', () {
    final TicketEntity entry = TicketEntity.fromMap(nicoEntry);
    final Map toEdit = {"clientPhone": "41996351984"};
    entry.edit(toEdit);

    expect(entry.toMap(), TicketEntity.fromMap(nicoEntryEditedPhone).toMap());
  });

  test('Should not edit (override) id field', () {
    final TicketEntity entry = TicketEntity.fromMap(nicoEntry);
    final Map toEdit = {"id": 5};
    entry.edit(toEdit);

    expect(entry.id, 1);
  });

  test('Should successful instantiate from map with missing id', () {
    Map map = {};
    nicoEntry.forEach((key, value) {
      if (key != 'id') map[key] = value;
    });
    final TicketEntity entry = TicketEntity.fromMap(map);

    expect(entry.id, -1);
  });

  test('Should successful instantiate from map with missing isFinished', () {
    Map map = {};
    nicoEntry.forEach((key, value) {
      if (key != 'isFinished') map[key] = value;
    });
    final TicketEntity entry = TicketEntity.fromMap(map);

    expect(entry.isFinished, false);
  });

  test('Should edit clientName with new value', () {
    final TicketEntity entry = TicketEntity.fromMap(nicoEntry);
    const newName = "New Name";
    entry.clientName = newName;

    expect(entry.clientName, newName);
  });
}
