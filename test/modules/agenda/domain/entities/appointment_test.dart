import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';

void main() {
  final nicoEntry = AppointmentEntity(
    id: 1,
    date: "2021-01-25",
    time: "10:00",
    duration: "01:00",
    ticketId: 2,
    isFinished: false,
  );

  final nicoEntryEditedPhone = AppointmentEntity(
    id: 2,
    date: "2021-01-12",
    time: "08:00",
    duration: "00:30",
    ticketId: 2,
    isFinished: false,
  );

  final nicoEntryEditedMulti = AppointmentEntity(
    id: 1,
    date: "2021-01-12",
    time: "08:00",
    duration: "00:30",
    ticketId: 2,
    isFinished: false,
  );

  const Map<String, dynamic> nicoEntryEditedPhoneMap = {
    "ticketId": 2,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false
  };

  const Map<String, dynamic> nicoEntryEditedMultiMap = {
    "ticketId": 2,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false
  };

  test('Id field should be not null, when given valid input', () {
    final entry = AppointmentEntity(
        date: "2021-01-25",
        time: "10:00",
        duration: "01:00",
        ticketId: 2,
        isFinished: false);

    expect(entry.id, equals(-1));
  });

  test('should have a default isFinished = false', () {
    final entry =
        AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");

    expect(entry.isFinished, equals(false));
  });

  test('should have a default ticketId = -1', () {
    final entry =
        AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");

    expect(entry.ticketId, equals(-1));
  });

  test('Should edit (override) all given fields', () {
    final entry = nicoEntry;
    entry.edit(nicoEntryEditedMultiMap);

    expect(entry.duration, nicoEntryEditedMulti.duration);
    expect(entry.date, nicoEntryEditedMulti.date);
    expect(entry.time, nicoEntryEditedMulti.time);
  });

  test('Should edit (override) only given fields', () {
    final entry = nicoEntry;
    final Map toEdit = {"clientPhone": "41996351984"};
    entry.edit(toEdit);

    expect(entry, nicoEntry);
  });

  test('Should not edit (override) id field', () {
    final entry = nicoEntry;
    final Map toEdit = {"id": 5};
    entry.edit(toEdit);

    expect(entry.id, 1);
  });

  test('Should parse date', () {
    final entry = AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");

    expect(entry.date, "2021-01-25");
  });

  test('Should set a new date', () {
    final entry = AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");
    entry.date = "2021-01-01";

    expect(entry.date, "2021-01-01");
  });

  test('Should parse time', () {
    final entry = AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");

    expect(entry.time, "10:00");
  });

  test('Should set a new time', () {
    final entry = AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");
    entry.time = "05:00";

    expect(entry.time, "05:00");
  });

  test('Should set duration to 1 hour', () {
    final entry = AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");

    expect(entry.duration, "01:00");
  });

  test('Should set duration to 2 hour', () {
    final entry = AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");
    entry.duration = "02:00";

    expect(entry.duration, "02:00");
  });

  test('final time should be 11:00h', () {
    final entry = AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");

    expect(entry.finalTime, "11:00");
  });

  test('Should return true if appointment date is before than DateTime.now())', () {
    final entry = AppointmentEntity(date: "2021-01-25", time: "10:00", duration: "01:00");

    expect(entry.hasPassed, true);
  });

  test('Should return false if appointment date is after than DateTime.now())', () {
    final entry = AppointmentEntity(date: "2100-01-25", time: "10:00", duration: "01:00");

    expect(entry.hasPassed, false);
  });
}
