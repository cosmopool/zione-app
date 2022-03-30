import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/agenda/data/mappers/appointment_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';



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
    final AppointmentEntity entry = AppointmentMapper.fromMap(nicoEntry);

    expect(entry.id, equals(1));
  });

  test('Should be instance of AppointmentEntity, given valid input', () {
    final AppointmentEntity entry = AppointmentMapper.fromMap(nicoEntry);

    expect(entry, isInstanceOf<AppointmentEntity>());
  });

  test('Should return map of an instance when toMap is called', () {
    final AppointmentEntity entry = AppointmentMapper.fromMap(nicoEntry);
    final Map toMap = AppointmentMapper.toMap(entry);

    expect(toMap, nicoEntry);
  });

  /* test('Should edit (override) all given fields', () { */
  /*   final AppointmentEntity entry = AppointmentEntity.fromMap(nicoEntry); */
  /*   entry.edit(nicoEntryEditedMulti); */
  /**/
  /*   expect(entry.toMap(), AppointmentEntity.fromMap(nicoEntryEditedMulti).toMap()); */
  /* }); */

  /* test('Should edit (override) only given fields', () { */
  /*   final AppointmentEntity entry = AppointmentEntity.fromMap(nicoEntry); */
  /*   final Map toEdit = {"clientPhone": "41996351984"}; */
  /*   entry.edit(toEdit); */
  /**/
  /*   expect(entry.toMap(), AppointmentEntity.fromMap(nicoEntryEditedPhone).toMap()); */
  /* }); */

  /* test('Should not edit (override) id field', () { */
  /*   final AppointmentEntity entry = AppointmentEntity.fromMap(nicoEntry); */
  /*   final Map toEdit = {"id": 5}; */
  /*   entry.edit(toEdit); */
  /**/
  /*   expect(entry.id, 1); */
  /* }); */

  test('Should successful instantiate from map with missing id', () {
    Map map = {};
    nicoEntry.forEach((key, value) {
      if (key != 'id') map[key] = value;
    });
    final entry = AppointmentMapper.fromMap(map);

    expect(entry.id, -1);
  });

  test('Should successful instantiate from map with missing isFinished field', () {
    Map map = {};
    nicoEntry.forEach((key, value) {
      if (key != 'isFinished') map[key] = value;
    });
    final entry = AppointmentMapper.fromMap(map);

    expect(entry.isFinished, false);
  });

  test('Should edit date field with new value', () {
  final entry = AppointmentMapper.fromMap(nicoEntry);
    const newDate = "2022-03-03";
    entry.date = newDate;

    expect(entry.date, newDate);
  });

  test('Should instantiate a list of maps', () {
    final list = [nicoEntry, nicoEntryEditedPhone, nicoEntryEditedMulti];
    final entryList = AppointmentMapper.fromMapList(list);

    expect(entryList[0], AppointmentMapper.fromMap(nicoEntry));
    expect(entryList[1], AppointmentMapper.fromMap(nicoEntryEditedPhone));
    expect(entryList[2], AppointmentMapper.fromMap(nicoEntryEditedMulti));
  });

  test('Should convert a list on entities fo a list of maps', () {
    final list = [AppointmentMapper.fromMap(nicoEntry), AppointmentMapper.fromMap(nicoEntryEditedPhone), AppointmentMapper.fromMap(nicoEntryEditedMulti),];
    final mapList = AppointmentMapper.toMapList(list);

    expect(mapList[0], nicoEntry);
    expect(mapList[1], nicoEntryEditedPhone);
    expect(mapList[2], nicoEntryEditedMulti);
  });

  /* test('Should edit date field with new value', () { */
  /* final entry = AppointmentMapper.fromMap(nicoEntry); */
  /**/
  /*   expect(entry.date, newDate); */
  /* }); */
}
