import 'package:flutter_test/flutter_test.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/utils/enums.dart';

final api = ApiServerDataSource();

void main() {
  test('Should receive authentication token on valid credentials', () async {
    final credentials = {"username": "kaio", "password": "kaio123"};
    final response = await api.postContent(Endpoint.login, credentials);
    final result = response.result[0];

    expect(result.runtimeType, String);
    expect(response.status, ResponseStatus.success);
  });
}
