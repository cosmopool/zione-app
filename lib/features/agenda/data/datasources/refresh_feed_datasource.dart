import 'package:zione/core/settings.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_refresh_feed_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

import 'local/i_cache_datasource.dart';

class RefreshFeedDataSource implements IRefreshFeedDataSouce {
  final ApiServerDataSource _server;
  final ICacheDatasource _cache;
  final Settings _settings;
  DateTime _lastTicketFetch = DateTime.utc(1989, DateTime.november, 9);
  DateTime _lastAgendaFetch = DateTime.utc(1989, DateTime.november, 9);
  DateTime _lastAppointmentFetch = DateTime.utc(1989, DateTime.november, 9);

  RefreshFeedDataSource(this._server, this._cache, this._settings);

  Future<List> _chooseServerOrCache(
      Endpoint endpoint, DateTime lastFetch) async {
    late IResponse response;
    final lastFetchInMinutes = DateTime.now().difference(lastFetch).inMinutes;

    if (lastFetchInMinutes < _settings.remoteServerRefreshTimeMinutes) {
      response = await _cache.fetchContent(endpoint);
    } else {
      response = await _server.fetchContent(endpoint);
      lastFetch = DateTime.now();

      if (response.status == ResponseStatus.success) {
        _cache.saveContent(endpoint, response);
      } else {
        response = await _cache.fetchContent(endpoint);
      }
    }
    return [response, lastFetch];
  }

  @override
  Future<IResponse> call(Endpoint endpoint) async {
    late IResponse response;
    late List _return;
    switch (endpoint) {
      case Endpoint.tickets:
        _return = await _chooseServerOrCache(endpoint, _lastTicketFetch);
        response = _return[0];
        _lastTicketFetch = _return[1];
        break;
      case Endpoint.agenda:
        _return = await _chooseServerOrCache(endpoint, _lastAgendaFetch);
        response = _return[0];
        _lastAgendaFetch = _return[1];
        break;
      case Endpoint.appointments:
        _return = await _chooseServerOrCache(endpoint, _lastAppointmentFetch);
        response = _return[0];
        _lastAppointmentFetch = _return[1];
        break;
    }
    return response;
  }
}
