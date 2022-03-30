import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/login/domain/entities/user_entity.dart';

void main() async {
  test('should return true when token is set', () async {
    final user = UserEntity(username: "kaio", password: "kaio123", token: "somekindoftoken");
    expect(user.tokenIsSet, true);
  });

  test('should return have false when token is empty ', () async {
    final user = UserEntity(username: "kaio", password: "kaio123");
    expect(user.tokenIsSet, false);
  });

  test('should return map with username and password', () async {
    final user = UserEntity(username: "kaio", password: "kaio123");
    final credentials = {'username': 'kaio', 'password': 'kaio123'};
    expect(user.credentials(), credentials);
  });
}
