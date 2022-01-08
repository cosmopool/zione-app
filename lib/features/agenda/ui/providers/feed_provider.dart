import 'package:flutter/material.dart';

import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/domain/repositories/feed_repository.dart';
import 'package:zione/features/agenda/domain/usecases/feed_usecases.dart';
import 'package:zione/features/agenda/domain/entities/entry_model.dart';
import 'package:zione/features/agenda/domain/entities/entry_card_model.dart';

class FeedProvider extends ChangeNotifier with FeedUseCases {
  FeedProvider({required this.feedRepository, required this.cardConstructor, required this.endpoint});
  final FeedRepositoryInterface feedRepository;
  final cardConstructor;
  final Endpoint endpoint;

  final List _feed = [];
  int _expandedCard = 0;

  int get expandedCard => _expandedCard;
  List get feed => _feed;

  @override
  void insertCard(Entry entry) {
    final EntryCard cardInstance  = cardConstructor(entry);
    _feed.insert(-1, cardInstance);
    notifyListeners();
  }

  @override
  void deleteCard(int cardId) {
    _feed.forEach((card) {
      if (card.id == cardId) _feed.remove(card);
    });
    notifyListeners();
  }

  @override
  void expandCard(int cardId) {
    _expandedCard = cardId;
    notifyListeners();
  }

  @override
  void closeCard() {
    _expandedCard = 0;
    notifyListeners();
  }

  @override
  void refresh() {
    feedRepository.fetch(endpoint);
    notifyListeners();
  }
}
