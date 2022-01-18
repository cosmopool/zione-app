import 'package:zione/utils/enums.dart';

abstract class EntryEntity {
  Entry get type;
  int get id;
  Map toMap();
  void edit(Map map);
}
