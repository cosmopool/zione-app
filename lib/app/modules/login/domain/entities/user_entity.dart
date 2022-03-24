class UserEntity {
  final String username;
  final String password;
  String token;

  UserEntity({
    required this.username,
    required this.password,
    this.token = "",
  });

  bool get tokenIsSet => token != "";

  Map<String, String> credentials() {
    return {"username": username, "password": password};
  }
}
