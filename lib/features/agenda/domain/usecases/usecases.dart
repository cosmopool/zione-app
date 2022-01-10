import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/domain/entities/entry_model.dart';

abstract class FeedUseCases {
  call(Endpoint endpoint);
}

abstract class CardUseCases {
  call(Entry entry, Endpoint endpoint);
}

class InsertCard extends CardUseCases {
  InsertCard({required this.entry, required this.endpoint});
  final Entry entry;
  final Endpoint endpoint;

  @override
  call(entry, endpoint) {}
}

class DeleteCard extends CardUseCases {
  DeleteCard({required this.entry, required this.endpoint});
  final Entry entry;
  final Endpoint endpoint;

  @override
  call(entry, endpoint) {}
}

class EditCard extends CardUseCases {
  EditCard({required this.entry, required this.endpoint});
  final Entry entry;
  final Endpoint endpoint;

  @override
  call(entry, endpoint) {}
}

class CloseCard extends CardUseCases {
  CloseCard({required this.entry, required this.endpoint});
  final Entry entry;
  final Endpoint endpoint;

  @override
  call(entry, endpoint) {}
}

class ExpandCard extends CardUseCases {
  ExpandCard({required this.entry, required this.endpoint});
  final Entry entry;
  final Endpoint endpoint;

  @override
  call(entry, endpoint) {}
}

class ShrinkCard extends CardUseCases {
  ShrinkCard({required this.entry, required this.endpoint});
  final Entry entry;
  final Endpoint endpoint;

  @override
  call(entry, endpoint) {}
}

class RefreshFeed extends FeedUseCases {
  RefreshFeed({required this.endpoint});
  final Endpoint endpoint;

  @override
  call(endpoint) {}
}

