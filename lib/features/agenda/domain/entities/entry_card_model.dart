import 'package:zione/features/agenda/domain/entities/entry_model.dart';

abstract class EntryCard {
  EntryCard({required this.entry});
  final Entry entry;

  int get id => entry.id;
}
