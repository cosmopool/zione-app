import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';

void main() {
  final nicoEntry = AgendaEntity(
    id: 1,
    date: "2021-01-25",
    time: "10:00",
    duration: "01:00",
    ticketId: 2,
    isFinished: false,
    clientName: "Nicodemos Biancato",
    clientPhone: "4199955566",
    clientAddress: "instalar as cameras na casa da frente",
    serviceType: "instalacao",
    description:
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    ticketIsFinished: false,
  );

  final nicoEntryEditedPhone = AgendaEntity(
    id: 2,
    date: "2021-01-12",
    time: "08:00",
    duration: "00:30",
    ticketId: 2,
    isFinished: false,
    clientName: "Nicodemos Biancato",
    clientPhone: "4199999999",
    clientAddress: "instalar as cameras na casa da frente",
    serviceType: "instalacao",
    description:
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    ticketIsFinished: false,
  );

  final nicoEntryEditedMulti = AgendaEntity(
    id: 1,
    date: "2021-01-12",
    time: "08:00",
    duration: "00:30",
    ticketId: 2,
    isFinished: false,
    clientName: "Nicodemos Biancato",
    clientPhone: "4199955566",
    clientAddress: "instalar as cameras na casa da frente",
    serviceType: "instalacao",
    description:
        "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    ticketIsFinished: false,
  );

  test('Id field should be not null, when given valid input', () {
    final entry = AgendaEntity(
      date: "2021-01-25",
      time: "10:00",
      duration: "01:00",
      ticketId: 2,
      isFinished: false,
      clientName: "Nicodemos Biancato",
      clientPhone: "4199955566",
      clientAddress: "instalar as cameras na casa da frente",
      serviceType: "instalacao",
      description:
          "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
      ticketIsFinished: false,
    );

    expect(entry.id.runtimeType, int);
  });

  test('should have id = 2', () {
    final entry = AgendaEntity(
      id: 2,
      date: "2021-01-25",
      time: "10:00",
      duration: "01:00",
      ticketId: 2,
      isFinished: false,
      clientName: "Nicodemos Biancato",
      clientPhone: "4199955566",
      clientAddress: "instalar as cameras na casa da frente",
      serviceType: "instalacao",
      description:
          "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
      ticketIsFinished: false,
    );

    expect(entry.id, 2);
  });

  test('should have a default isFinished and ticketIsFinished = false', () {
    final entry = AgendaEntity(
      id: 1,
      date: "2021-01-25",
      time: "10:00",
      duration: "01:00",
      ticketId: 2,
      clientName: "Nicodemos Biancato",
      clientPhone: "4199955566",
      clientAddress: "instalar as cameras na casa da frente",
      serviceType: "instalacao",
      description:
          "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
    );

    expect(entry.isFinished, false);
    expect(entry.ticketIsFinished, false);
  });

  test('should have a default ticketId = -1', () {
    final entry = AgendaEntity(
      date: "2021-01-25",
      time: "10:00",
      duration: "01:00",
      isFinished: false,
      clientName: "Nicodemos Biancato",
      clientPhone: "4199955566",
      clientAddress: "instalar as cameras na casa da frente",
      serviceType: "instalacao",
      description:
          "- Falar com Fatima\r\n- Instalar as cameras na casa da frente",
      ticketIsFinished: false,
    );

    expect(entry.ticketId, equals(-1));
  });
}
