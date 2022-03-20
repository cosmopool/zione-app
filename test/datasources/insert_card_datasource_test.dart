import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';

final entry = TicketEntity(
    clientName: "Gustavoide",
    clientPhone: "41999000333",
    clientAddress: "Rua dos Minecraftero, 132",
    serviceType: "Instalacao",
    description: "Instalar o minecraft");
const Map json = {
  "Status": "Success",
  "Result": "Success message from server."
};

void main() async {
  /*   await Hive.initFlutter(); */
  /*   Hive.registerAdapter(ResponseStatusAdapter()); */
  /*   Hive.registerAdapter(ResponseAdapter()); */
  /*   Hive.registerAdapter(TicketEntityAdapter()); */
  /*   var _box = await Hive.openBox('testBox'); */
  /*   final _cache = HiveDatasouce(_box); */
  /**/
  /* setUp(() async { */
  /*   await setUpTestHive(); */
  /* }); */
  /**/
  /* test('Should save entry in ToSync box', () async { */
  /*   const endpoint = Endpoint.tickets; */
  /*   final table = endpoint.name + "ToSync"; */
  /*   final server = ErrorApiServerDatasourceTest(); */
  /*   final insert = InsertCardDataSource(server, _cache); */
  /*   /* final didSave = await insert(entry, endpoint); */ */
  /*   /* final didSave = await _cache.saveToSyncContent(endpoint, entry); */ */
  /*   try { */
  /*     /* final didSave = await _cache.saveToSyncContent(endpoint, entry); */ */
  /*     await _box.put(table, [entry]); */
  /*   } catch (e) { */
  /*     print(e); */
  /*   } */
  /*   /* await _box.put(table, [entry]); */ */
  /*   /* final toSync = await _box.get(table); */ */
  /*   final toSync = await _cache.fetchToSyncContent(endpoint); */
  /*   /* print("toSync --------------------------- \n $toSync"); */ */
  /**/
  /*   /* expect(didSave, true); */ */
  /*   expect(toSync.length, greaterThan(0)); */
  /* }); */
  /**/
  /* tearDown(() async { */
  /*   await tearDownTestHive(); */
  /* }); */
  test('Should save entry in ToSync box', () async {
  });
}
