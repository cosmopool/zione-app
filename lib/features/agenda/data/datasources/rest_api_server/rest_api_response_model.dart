import 'package:hive/hive.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

part 'rest_api_response_model.g.dart';

@HiveType(typeId: 1)
class Response implements IResponse {
  @HiveField(0)
  late ResponseStatus _status;
  @HiveField(1)
  late dynamic _result;
  @HiveField(2)
  bool _offline = false;

  @override
  ResponseStatus get status => _status;
  @override
  get result => _result;
  @override
  bool get isSuccessful => (status == ResponseStatus.success);
  // @HiveField(3)
  @override
  bool get isServerOffline => _offline;

  Response(Map json) {
    switch (json['Status']) {
      case 'Success': _status = ResponseStatus.success; break;
      case 'Error': _status = ResponseStatus.err; break;
      default: _status = ResponseStatus.err; break;
    }

    if (json['Result'] != null) _result = json['Result'];
  }

  Response.noConnection(){
    _status = ResponseStatus.err;
    _result = "No connection with remote server";
    _offline = true;
  }
}
