import 'package:logging/logging.dart';
import 'package:zione/core/settings.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/i_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_refresh_feed_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

import 'local/i_cache_datasource.dart';

class RefreshFeedDataSource implements IRefreshFeedDataSouce {
  final IApiDatasource _server;
  final ICacheDatasource _cache;
  final Settings _settings;
  DateTime _lastTicketFetch = DateTime.utc(1989, DateTime.november, 9);
  DateTime _lastAgendaFetch = DateTime.utc(1989, DateTime.november, 9);
  DateTime _lastAppointmentFetch = DateTime.utc(1989, DateTime.november, 9);

  RefreshFeedDataSource(this._server, this._cache, this._settings);

  final log = Logger('RefreshUsecase');

  Future<List> _chooseServerOrCache(
      Endpoint endpoint, DateTime lastFetch) async {
    late IResponse response;
    final lastFetchInMinutes = DateTime.now().difference(lastFetch).inMinutes;
    log.info("[REFRESH] Last with api server was $lastFetchInMinutes minutes");

    if (lastFetchInMinutes < _settings.remoteServerRefreshTimeMinutes) {
      log.info("[REFRESH] Fetching from cache");
      response = await _cache.fetchContent(endpoint);
    } else {
      log.info("[REFRESH] Fetching from server");
      response = await _server.fetchContent(endpoint);
      lastFetch = DateTime.now();

      if (response.status == ResponseStatus.success) {
        log.info("[REFRESH] Received a successful response from server");
        log.info("[REFRESH] Updating content in cache");
        _cache.saveContent(endpoint, response);
      } else {
        log.info("[REFRESH] Received a unsuccessful response from server");
        log.finest("[REFRESH] Result from response: ${response.result}");
        log.info("[REFRESH] Fetching old content from cache");
        response = await _cache.fetchContent(endpoint);
      }
    }
    return [response, lastFetch];
  }

  @override
  Future<IResponse> call(Endpoint endpoint) async {
    log.info("[REFRESH] Start refreshing ${endpoint.name} feed");
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
      default: break;
    }
    return response;
  }
}
