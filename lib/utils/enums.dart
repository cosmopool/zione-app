
// rest api response status
import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 2)
enum ResponseStatus { 
  @HiveField(0)
  success, 
  @HiveField(1)
  err }
// rest api endpoint
enum Endpoint { tickets, appointments, agenda, login, users }
// ticket menu
enum EntryAction { delete, edit, close }
// entry type
enum Entry { ticket, appointment, agenda}
