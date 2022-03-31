import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/agenda/data/mappers/agenda_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';



void main() {
  const Map<String, dynamic> nicoEntry = {
    "id": 1,
    "date": "2021-01-25",
    "time": "10:00",
    "duration": "01:00",
    "ticketId": 2,
    "isFinished": false,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "4199955566",
    "clientAddress": "instalar as cameras na casa da frente",
    "serviceType": "instalacao",
    "description":
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    "ticketIsFinished": false,
  };

  const Map<String, dynamic> nicoEntryEditedPhone = {
    "ticketId": 2,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "4199955566",
    "clientAddress": "instalar as cameras na casa da frente",
    "serviceType": "instalacao",
    "description":
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    "ticketIsFinished": false,
  };

  const Map<String, dynamic> nicoEntryEditedMulti = {
    "ticketId": 2,
    "id": 1,
    "date": "2021-01-12",
    "time": "08:00",
    "duration": "00:30",
    "isFinished": false,
    "clientName": "Nicodemos Biancato",
    "clientPhone": "4199955566",
    "clientAddress": "instalar as cameras na casa da frente",
    "serviceType": "instalacao",
    "description":
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    "ticketIsFinished": false,
  };

  test('Id field should be not null, when given valid input', () {
    final AgendaEntity entry = AgendaMapper.fromMap(nicoEntry);

    expect(entry.id.runtimeType, int);
  });

  test('Should be instance of AgendaEntity, given valid input', () {
    final AgendaEntity entry = AgendaMapper.fromMap(nicoEntry);

    expect(entry, isInstanceOf<AgendaEntity>());
  });

  test('Should return map of an instance when toMap is called', () {
    final AgendaEntity entry = AgendaMapper.fromMap(nicoEntry);
    final Map toMap = AgendaMapper.toMap(entry);

    expect(toMap, nicoEntry);
  });

  test('Should successful instantiate from map with missing id', () {
    Map map = {};
    nicoEntry.forEach((key, value) {
      if (key != 'id') map[key] = value;
    });
    final entry = AgendaMapper.fromMap(map);

    expect(entry.id, -1);
  });

  test('Should successful instantiate from map with missing isFinished field', () {
    Map map = {};
    nicoEntry.forEach((key, value) {
      if (key != 'isFinished') map[key] = value;
    });
    final entry = AgendaMapper.fromMap(map);

    expect(entry.isFinished, false);
  });

  test('Should edit date field with new value', () {
  final entry = AgendaMapper.fromMap(nicoEntry);
    const newDate = "2022-03-03";
    entry.date = newDate;

    expect(entry.date, newDate);
  });

  test('Should instantiate a list of maps', () {
    final list = [nicoEntry, nicoEntryEditedPhone, nicoEntryEditedMulti];
    final entryList = AgendaMapper.fromMapList(list);

    expect(entryList[0], AgendaMapper.fromMap(nicoEntry));
    expect(entryList[1], AgendaMapper.fromMap(nicoEntryEditedPhone));
    expect(entryList[2], AgendaMapper.fromMap(nicoEntryEditedMulti));
  });

  test('Should convert a list on entities fo a list of maps', () {
    final list = [AgendaMapper.fromMap(nicoEntry), AgendaMapper.fromMap(nicoEntryEditedPhone), AgendaMapper.fromMap(nicoEntryEditedMulti),];
    final mapList = AgendaMapper.toMapList(list);

    expect(mapList[0], nicoEntry);
    expect(mapList[1], nicoEntryEditedPhone);
    expect(mapList[2], nicoEntryEditedMulti);
  });

  test('Should return appointment', () {
    final ag = AgendaMapper.fromMap(nicoEntry);
    final ap = AgendaMapper.toAppointment(ag);

    expect(ap, AppointmentEntity(date: ag.date, time: ag.time, duration: ag.duration));
  });

  test('Should return ticket', () {
  });
}
