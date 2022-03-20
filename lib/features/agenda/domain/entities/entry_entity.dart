import 'package:zione/utils/enums.dart';

abstract class EntryEntity {
  Endpoint get endpoint;
  Entry get type;
  int get id;
  Map toMap();
  void edit(Map map);
}
