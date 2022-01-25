import 'package:zione/utils/enums.dart';

abstract class IResponse {
  ResponseStatus get status;
  get result;
  bool get isSuccessful;
  bool get isServerOffline;
}
