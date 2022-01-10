import 'package:zione/features/agenda/domain/entities/entry_model.dart';

abstract class FeedUseCases {
  void insertCard(Entry entry);
  void deleteCard(Entry entry);
  void closeCard(Entry entry);
  void expandCard(int cardId);
  void shrinkCard();
  void refresh();
}
