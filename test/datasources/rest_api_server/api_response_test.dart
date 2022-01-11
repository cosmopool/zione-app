import 'package:flutter_test/flutter_test.dart';

import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/data/models/rest_api_response_model.dart';

void main() {
  test('Status should return success given valid response', () {
    const Map json = {"Status":"Success", "Result":"Success message from server."};
    final response = Response(json);

    expect(response.status, equals(ResponseStatus.success));
  });

  test('Status should return error given valid response', () {
    const Map json = {"Status":"Error", "Result":"Success message from server."};
    final response = Response(json);

    expect(response.status, equals(ResponseStatus.err));
  });

  test('Status should return error given invalid response', () {
    const Map json = {"msg": "Invalid message from server."};
    final response = Response(json);

    expect(response.status, equals(ResponseStatus.err));
  });

  test('Result should return single map given invalid response', () {
    const Map json = {"Status":"Success", "Result":{"id": 1}};
    final response = Response(json);

    expect(response.result["id"], equals(1));
  });

  test('Result should return list of maps given invalid response', () {
    const Map json = {"Status":"Success", "Result":[{"id": 1}, {"id": 2}]};
    final response = Response(json);

    expect(response.result[1]["id"], equals(2));
  });
}


