import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zione/core/auth.dart';
import 'package:zione/core/utils/constants.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/i_datasource.dart';
import 'package:zione/features/agenda/data/datasources/remote/api_datasource.dart';

import '../../../stubs/ticket_list_stubs.dart';

void main() async {
  const tkEndpoint = Endpoint.tickets;
  late IDatasource api;

  setUp(() async {
    host = "0.0.0.0";
    port = "80";
    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY0Nzk4MDcwOCwianRpIjoiODVlNjRmNmYtN2UwZC00ZWY3LWFmZWEtOTQxZmI4MTU0YjgwIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImthaW8iLCJuYmYiOjE2NDc5ODA3MDh9.WnfLrkGrqr7_G7FktuSCrpreUnfsleWesk-AEwqxY6w";
    api = ApiServerDataSource(uriMethod: Uri.http);
  });

  test('should close a ticket when given valid input', () async {
    late List<Map> ticketList;

    // post a new ticket
    Map tk = ticketListStub[0];
    tk.remove('id');
    await api.postContent(tkEndpoint, tk);

    // get this new ticket id
    var fetch = await api.fetchContent(tkEndpoint);
    fetch.fold((l) => null, (r) => ticketList = r);
    final newTicket = ticketList.last;

    // close the new ticket
    await api.closeContent(tkEndpoint, newTicket);

    // check that the new ticket is closed
    fetch = await api.fetchContent(tkEndpoint);
    fetch.fold((l) => null, (r) => ticketList = r);
    expect(ticketList.last != newTicket, true);
  });

  test('should return true when given valid input', () async {
    late List<Map> ticketList;

    // post a new ticket
    Map tk = ticketListStub[0];
    tk.remove('id');
    await api.postContent(tkEndpoint, tk);

    // get this new ticket id
    final fetch = await api.fetchContent(tkEndpoint);
    fetch.fold((l) => null, (r) => ticketList = r);

    // close this new ticket
    final res = await api.closeContent(tkEndpoint, ticketList.last);
    expect(res, right(true));
  });

}
