import 'package:zione/features/agenda/domain/entities/entry_model.dart';

abstract class FeedUseCases {
  void insertCard(Entry entry);
  void deleteCard(Entry entry);
  void expandCard(int cardId);
  void closeCard();
  void refresh();
}
