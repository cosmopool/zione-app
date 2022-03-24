import 'package:hive/hive.dart';

abstract class ISettings {
  Future<int> get remoteApiRefreshTimeMinutes;
  Future<int> get tryReconnectCount;
  Future<String> get token;
  Future<String> get host;
  Future<String> get port;
}

class Settings implements ISettings {
  Box _box;

  Settings(this._box);

  @override
  Future<int> get remoteApiRefreshTimeMinutes async =>
      await _box.get('remoteApiRefreshTimeMinutes', defaultValue: 10);

  @override
  Future<int> get tryReconnectCount async =>
      await _box.get('tryReconnectCount', defaultValue: 3);

  @override
  Future<String> get host async => await _box.get('host', defaultValue: "api.delforte.com.br");

  @override
  Future<String> get port async => await _box.get('port', defaultValue: "443");

  @override
  Future<String> get token async => await _box.get('authenticationToken', defaultValue: "");
}
