import 'package:flutter_test/flutter_test.dart';
import 'package:zione/utils/enums.dart';

void main() {
  test('Test enum ticket endpoint to string', () {
    final endpoint = Endpoint.tickets.name;
    expect(endpoint, "tickets");
  });

  test('Test enum appointment endpoint to string', () {
    expect(Endpoint.appointments.name, "appointments");
  });

  test('Test enum agenda endpoint to string', () {
    expect(Endpoint.agenda.name, "agenda");
  });

  test('Test enum users endpoint to string', () {
    expect(Endpoint.users.name, "users");
  });

  test('Test enum login endpoint to string', () {
    expect(Endpoint.login.name, "login");
  });
}
