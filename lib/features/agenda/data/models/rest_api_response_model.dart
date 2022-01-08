import 'dart:convert';
import 'package:zione_app/utils/enums.dart';

class Response {
  late ResponseStatus status;
  late String result;

  Response(Map json) {
    switch (json['Status']) {
      case 'Success': { status = ResponseStatus.success; } break;
      case 'Error': { status = ResponseStatus.err; } break;
      default: { status = ResponseStatus.err; } break;
    }

    if (json['Result'] != null) {
      result = json['Result'] as String;
    } else {
      result = json as String;
    }
  }

  List resultToList() {
    if (status == ResponseStatus.success) {
      return jsonDecode(result);
    } else {
      return [];
    }
  }
}
