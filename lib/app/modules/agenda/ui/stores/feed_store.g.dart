// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedStore on _FeedStore, Store {
  final _$loadingAtom = Atom(name: '_FeedStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$failureAtom = Atom(name: '_FeedStore.failure');

  @override
  Failure get failure {
    _$failureAtom.reportRead();
    return super.failure;
  }

  @override
  set failure(Failure value) {
    _$failureAtom.reportWrite(value, super.failure, () {
      super.failure = value;
    });
  }

  final _$ticketsAtom = Atom(name: '_FeedStore.tickets');

  @override
  List<TicketEntity> get tickets {
    _$ticketsAtom.reportRead();
    return super.tickets;
  }

  @override
  set tickets(List<TicketEntity> value) {
    _$ticketsAtom.reportWrite(value, super.tickets, () {
      super.tickets = value;
    });
  }

  final _$fetchTicketsAsyncAction = AsyncAction('_FeedStore.fetchTickets');

  @override
  Future<void> fetchTickets() {
    return _$fetchTicketsAsyncAction.run(() => super.fetchTickets());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
failure: ${failure},
tickets: ${tickets}
    ''';
  }
}
