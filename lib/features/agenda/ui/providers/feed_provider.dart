import 'package:flutter/material.dart';
import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';
import 'package:zione/features/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/domain/usecases/i_close_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_delete_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_insert_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_refresh_feed_usecase.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

abstract class IFeedProvider {
  int get cardExpandedId;
  bool get result;
  bool get isLoading;
  List<TicketEntity> get ticketFeed;
  List get agendaEntryFeed;
  List<AppointmentEntity> get appointmentFeed;
  Map get ticketFeedByDate;
  Map get agendaEntryFeedByDate;
  void _populateFeed(IResponse response, Endpoint endpoint);
  void _indexEntryByDate(entry, map);
  void refresh(Endpoint endpoint);
  void delete(EntryEntity entry, Endpoint endpoint);
  void insert(EntryEntity entry, Endpoint endpoint);
  void close(EntryEntity entry, Endpoint endpoint);
}

class FeedProvider extends ChangeNotifier with IFeedProvider {
  final IInsertCardUseCase _insert;
  final ICloseCardUsecase _close;
  final IDeleteCardUseCase _delete;
  final IRefreshFeedUsecase _refresh;

  int _cardExpandedId = 0;
  List<TicketEntity> _ticketFeed = [];
  final List _agendaEntryFeed = [];
  List<AppointmentEntity> _appointmentFeed = [];
  Map _ticketFeedIndexedByDate = {};
  Map _agendaFeedIndexedByDate = {};
  Map _appointmentFeedIndexedByDate = {};
  bool _result = false;
  bool _isLoading = false;

  FeedProvider(this._insert, this._close, this._delete, this._refresh);

  @override
  int get cardExpandedId => _cardExpandedId;
  @override
  bool get result => _result;
  @override
  bool get isLoading => _isLoading;
  @override
  List<TicketEntity> get ticketFeed => _ticketFeed;
  @override
  List get agendaEntryFeed => _agendaEntryFeed;
  @override
  List<AppointmentEntity> get appointmentFeed => _appointmentFeed;
  @override
  Map get ticketFeedByDate => _ticketFeedIndexedByDate;
  @override
  Map get agendaEntryFeedByDate => _agendaFeedIndexedByDate;

  @override
  void _populateFeed(IResponse response, Endpoint endpoint) {
    if (response.status == ResponseStatus.success) {
      switch (endpoint) {
        case Endpoint.tickets:
          {
            response.result.forEach((entry, key) {
              final _entry = TicketEntity(entry);
              _ticketFeed.add(_entry);
            });
          }
          break;
        case Endpoint.appointments:
          {
            response.result.forEach((entry, key) {
              final _entry = AppointmentEntity(entry);
              _appointmentFeed.add(_entry);
              _indexEntryByDate(entry, _appointmentFeedIndexedByDate);
            });
          }
          break;
        case Endpoint.agenda:
          {
            response.result.forEach((entry) {
              final _entry = AgendaEntryEntity(entry);
              _agendaEntryFeed.add(_entry);
              _indexEntryByDate(_entry, _agendaFeedIndexedByDate);
            });
          }
          break;
      }
    }
  }

  @override
  void _indexEntryByDate(entry, map) {
    final date = entry.date;

    if (map[date] == null) {
      map[date] = [];
    }

    map[date].add(entry);
  }

  @override
  void refresh(Endpoint endpoint) async {
    final IResponse response = await _refresh(endpoint);
    _populateFeed(response, endpoint);
    notifyListeners();
  }

  @override
  void delete(EntryEntity entry, Endpoint endpoint) async {
    _result = await _delete(entry, endpoint);
    result ? refresh(endpoint) : null;
    notifyListeners();
  }

  @override
  void insert(EntryEntity entry, Endpoint endpoint) async {
    _result = await _insert(entry, endpoint);
    result ? refresh(endpoint) : null;
    notifyListeners();
  }

  @override
  void close(EntryEntity entry, Endpoint endpoint) async {
    _result = await _close(entry, endpoint);
    result ? refresh(endpoint) : null;
    notifyListeners();
  }
}
