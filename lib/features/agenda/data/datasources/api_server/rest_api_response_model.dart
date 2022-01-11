import 'dart:convert';

import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class Response implements IResponse {
  @override
  late ResponseStatus status;
  @override
  late var result;

  @override
  Response(Map json) {
    switch (json['Status']) {
      case 'Success': { status = ResponseStatus.success; } break;
      case 'Error': { status = ResponseStatus.err; } break;
      default: { status = ResponseStatus.err; } break;
    }

    if (json['Result'] != null) result = json['Result'];
  }

  List resultToList() {
    if (status == ResponseStatus.success) {
      return jsonDecode(result);
    } else {
      return [];
    }
  }
}
