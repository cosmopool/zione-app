import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/settings.dart';

class SettingsStub implements ISettings {
  bool shouldFail = false;
  Failure failure = ServerSideFailure();

  @override
  Future<String> get host async => "0.0.0.0";

  @override
  Future<String> get port async => "80";

  @override
  Future<int> get remoteApiRefreshTimeMinutes async => 10;

  @override
  Future<String> get token async => "some_token";

  @override
  Future<int> get tryReconnectCount async => 3;
}
