import 'package:flutter/material.dart';

import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/domain/repositories/feed_repository_interface.dart';
import 'package:zione/features/agenda/domain/usecases/feed_usecases.dart';
import 'package:zione/features/agenda/domain/entities/entry_model.dart';

class FeedProvider extends ChangeNotifier with FeedUseCases {
  FeedProvider({required this.feedRepository, required this.cardConstructor, required this.endpoint});
  final FeedRepositoryInterface feedRepository;
  final cardConstructor;
  final Endpoint endpoint;
  ResponseStatus _responseStatus = ResponseStatus.err;

  final List _feed = [];
  int _expandedCard = 0;

  List get feed => _feed;
  int get expandedCard => _expandedCard;
  ResponseStatus get responseStatus => _responseStatus;

  @override
  void insertCard(Entry entry) async {
    final result = await feedRepository.insert(endpoint, entry);
    _responseStatus = result;
    notifyListeners();
  }

  @override
  void deleteCard(Entry entry) async {
    final result = await feedRepository.delete(endpoint, entry);
    _responseStatus = result;
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
  void refresh() async {
    final result = await feedRepository.fetch(endpoint);
    _responseStatus = result;
    notifyListeners();
  }
}
