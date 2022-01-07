import 'package:zione/features/agenda/domain/entities/entry_model.dart';
import 'package:zione/features/agenda/domain/entities/entry_card_model.dart';

abstract class FeedUseCases {
  void insertCard(Entry entry);
  void deleteCard(EntryCard entryCard);
  void expandCard(int cardId);
  void closeCard();
  void refresh();

