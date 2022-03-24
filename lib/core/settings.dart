import 'package:hive/hive.dart';

abstract class ISettings {
  Future<int> get remoteApiRefreshTimeMinutes;
  Future<int> get tryReconnectCount;
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
}
