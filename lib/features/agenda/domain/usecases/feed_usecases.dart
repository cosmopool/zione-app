import 'package:zione/features/agenda/domain/entities/entry_model.dart';

abstract class FeedUseCases {
  void insertCard(Entry entry);
  void deleteCard(int cardId);
  void expandCard(int cardId);
  void closeCard();
  void refresh();

