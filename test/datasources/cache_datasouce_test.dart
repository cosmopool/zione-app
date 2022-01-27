import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:zione/features/agenda/data/datasources/local/hive_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

import 'rest_api_server/rest_api_server_json_response.dart';

main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ResponseStatusAdapter());
  Hive.registerAdapter(ResponseAdapter());
  await Hive.openBox('testBox');

  Box? testBox = await Hive.openBox('testBox');

  final cache = HiveDatasouce(testBox);
  final initialResponse = Response({'Status': 'Success', 'Result': 0});
  final response = Response({'Status': 'Success', 'Result': 41});
  final json = agendaEndpoint;
  final agendaResponse = Response(json);

  testBox.put('appointments', initialResponse);

  test('Should fetch content from cache', () async {
    final IResponse _response = await cache.fetchContent(Endpoint.appointments);
    expect(_response.result, 0);
  });

  test('Should save content in cache', () async {
    await cache.saveContent(Endpoint.appointments, response);
    final IResponse _response = await testBox!.get('appointments');
    expect(_response.result, 41);
  });

  test('Saved data should be persistent when db is closed without save', () async {
    testBox = null;
    var newBox = await Hive.openBox('testBox');
    final newCache = HiveDatasouce(newBox);
    final IResponse response = await newCache.fetchContent(Endpoint.appointments);
    expect(response.result, 41);
  });

  test('Saved data should have same type when fetched', () async {
    await cache.saveContent(Endpoint.agenda, agendaResponse);
    final IResponse response = await cache.fetchContent(Endpoint.agenda);
    expect(response.result.runtimeType, json['Result'].runtimeType);
  });

  // test('Saved data should have same type when fetched', () async {
  //   await cache.saveContent(Endpoint.agenda, agendaResponse);
  //   testBox = null;
  //   var newBox = await Hive.openBox('testBox');
  //   final newCache = HiveDatasouce(newBox);
  //   final IResponse response = await newCache.fetchContent(Endpoint.agenda);

  //   print(response.result[0].runtimeType);
  //   print(json['Result'][0].runtimeType);
  //   expect(response.result[0].runtimeType, json['Result'][0].runtimeType);
  // });
}
