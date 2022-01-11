import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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

class FeedProvider extends ChangeNotifier {
  final IInsertCardUseCase _insert = GetIt.instance.get<InsertCardUseCase>();
  final ICloseCardUsecase _close = GetIt.instance.get<CloseCardUsecase>();
  final IDeleteCardUseCase _delete = GetIt.instance.get<DeleteCardUseCase>();
  final IRefreshFeedUsecase _refresh = GetIt.instance.get<RefreshFeedUsecase>();

  int _cardExpandedId = 0;
  List<TicketEntity> _ticketFeed = [];
  List<AgendaEntryEntity> _agendaEntryFeed = [];
  List<AppointmentEntity> _appointmentFeed = [];
  Map _ticketFeedIndexedByDate = {};
  Map _agendaFeedIndexedByDate = {};
  Map _appointmentFeedIndexedByDate = {};
  bool _result = false;

  int get cardExpandedId => _cardExpandedId;
  bool get result => _result;
  List<TicketEntity> get ticketFeed => _ticketFeed;
  List<AgendaEntryEntity> get agendaEntryFeed => _agendaEntryFeed;
  List<AppointmentEntity> get appointmentFeed => _appointmentFeed;

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
            response.result.forEach((entry, key) {
              final _entry = AgendaEntryEntity(entry);
              _agendaEntryFeed.add(_entry);
              _indexEntryByDate(entry, _agendaFeedIndexedByDate);
            });
          }
          break;
      }
    }
  }

  void _indexEntryByDate(entry, map) {
    final date = entry.date;

    if (map[date] == null) {
      map[date] = [];
    }

    map[date].add(entry);
  }

  void refresh(Endpoint endpoint) async {
    final IResponse response = await _refresh(endpoint);
    _populateFeed(response, endpoint);
    notifyListeners();
  }

  void delete(EntryEntity entry, Endpoint endpoint) async {
    _result = await _delete(entry, endpoint);
    result ? refresh(endpoint) : null;
    notifyListeners();
  }

  void insert(EntryEntity entry, Endpoint endpoint) async {
    _result = await _insert(entry, endpoint);
    result ? refresh(endpoint) : null;
    notifyListeners();
  }

  void close(EntryEntity entry, Endpoint endpoint) async {
    _result = await _close(entry, endpoint);
    result ? refresh(endpoint) : null;
    notifyListeners();
  }
}
