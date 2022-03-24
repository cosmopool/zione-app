import 'package:hive_flutter/hive_flutter.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

part 'response.g.dart';

@HiveType(typeId: 3)
class Response {
  late Status _status;
  late dynamic _result;
  bool _offline = false;

  @HiveField(0)
  Status get status => _status;

  @HiveField(1)
  get result => _result;

  @HiveField(2)
  bool get isSuccessful => (status == Status.success);

  @HiveField(3)
  bool get isServerOffline => _offline;

  Response(
      {required Status status, required dynamic result, bool offline = false})
      : _status = status,
        _result = result,
        _offline = offline;

  Response.fromMap(Map json) {
    switch (json['Status']) {
      case 'Success':
        _status = Status.success;
        break;
      case 'Error':
        _status = Status.err;
        break;
      default:
        _status = Status.err;
        break;
    }

    if (json['Result'] != null) _result = json['Result'];
  }

  Response.noConnection() {
    _status = Status.err;
    _result = "No connection with remote server";
    _offline = true;
  }
}
