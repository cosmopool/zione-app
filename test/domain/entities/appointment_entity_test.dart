import 'package:flutter_test/flutter_test.dart';

import 'package:zione/features/agenda/domain/entities/appointment_entity.dart';

void main() {
  const Map<String, dynamic> nicoEntry = {
    "ticketId": 2,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false
  };

  const Map<String, dynamic> nicoEntryEditedPhone = {
    "ticketId": 2,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false
  };

  const Map<String, dynamic> nicoEntryEditedMulti = {
    "ticketId": 2,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false
  };

  test('Id field should be not null, when given valid input', () {
    final AppointmentEntity entry = AppointmentEntity(nicoEntry);

    expect(entry.id, equals(1));
  });

  test('Should be instance of AppointmentEntity, given valid input', () {
    final AppointmentEntity entry = AppointmentEntity(nicoEntry);

    expect(entry, isInstanceOf<AppointmentEntity>());
  });

  test('Should return map of an instance when toMap is called', () {
    final AppointmentEntity entry = AppointmentEntity(nicoEntry);
    final Map toMap = entry.toMap();

    expect(toMap, nicoEntry);
  });

  test('Should edit (override) all given fields', () {
    final AppointmentEntity entry = AppointmentEntity(nicoEntry);
    entry.edit(nicoEntryEditedMulti);

    expect(entry.toMap(), AppointmentEntity(nicoEntryEditedMulti).toMap());
  });

  test('Should edit (override) only given fields', () {
    final AppointmentEntity entry = AppointmentEntity(nicoEntry);
    final Map toEdit = {"clientPhone": "41996351984"};
    entry.edit(toEdit);

    expect(entry.toMap(), AppointmentEntity(nicoEntryEditedPhone).toMap());
  });

  test('Should not edit (override) id field', () {
    final AppointmentEntity entry = AppointmentEntity(nicoEntry);
    final Map toEdit = {"id": 5};
    entry.edit(toEdit);

    expect(entry.id, 1);
  });
}
