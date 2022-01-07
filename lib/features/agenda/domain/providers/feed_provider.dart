import 'package:flutter/material.dart';

import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/domain/repositories/feed_repository.dart';
import 'package:zione/features/agenda/domain/entities/entry_model.dart';
import 'package:zione/features/agenda/domain/entities/entry_card_model.dart';

class FeedProvider extends ChangeNotifier {
  FeedProvider({required this.feedRepository, required this.cardConstructor, required this.endpoint});
  final FeedRepository feedRepository;
  final cardConstructor;
  final Endpoint endpoint;

  final List _feed = [];
  int _expandedCard = 0;

  int get expandedCard => _expandedCard;
  List get feed => _feed;

  void insertCard(Entry entry) {
    final EntryCard cardInstance  = cardConstructor(entry);
    _feed.insert(-1, cardInstance);
    notifyListeners();
  }

  void deleteCard(EntryCard entryCard) {
    _feed.forEach((card) {
      if (card.id == entryCard.id) _feed.remove(card);
    });
    notifyListeners();
  }

  void expandCard(int cardId) {
    _expandedCard = cardId;
    notifyListeners();
  }

  void closeCard() {
    _expandedCard = 0;
    notifyListeners();
  }

  void refresh() {
    feedRepository.fetch(endpoint);
    notifyListeners();
  }
}
