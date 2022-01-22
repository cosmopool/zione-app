import 'package:zione/core/settings.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_refresh_feed_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

import 'local/cache_datasource.dart';

class RefreshFeedDataSource implements IRefreshFeedDataSouce  {
  final ApiServerDataSource _server;
  final ICacheDatasource _cache;
  final Settings _settings;
  late IResponse agendaCache;
  late IResponse ticketsCache;
  late IResponse appointmentsCache;
  DateTime _lastTicketFetch = DateTime.utc(1989, DateTime.november, 9);
  DateTime _lastAgendaFetch = DateTime.utc(1989, DateTime.november, 9);
  DateTime _lastAppointmentFetch = DateTime.utc(1989, DateTime.november, 9);

  RefreshFeedDataSource(this._server, this._cache, this._settings);

  @override
  Future<IResponse> call(Endpoint endpoint) async {
    late final IResponse response;
    switch (endpoint) {
      case Endpoint.tickets:
        {
          final lastFetchInMinutes = DateTime.now().difference(_lastTicketFetch).inMinutes;
          if (lastFetchInMinutes < _settings.remoteServerRefreshTimeMinutes) {
            response = ticketsCache;
          } else {
            response = await _server.fetchContent(endpoint);
            _lastTicketFetch = DateTime.now();

            if (response.status == ResponseStatus.success) {
              ticketsCache = response;
            }
          }
        }
        break;
      case Endpoint.agenda:
        {
          final lastFetchInMinutes = DateTime.now().difference(_lastAgendaFetch).inMinutes;
          if (lastFetchInMinutes < _settings.remoteServerRefreshTimeMinutes) {
            response = agendaCache;
          } else {
            response = await _server.fetchContent(endpoint);
            _lastAgendaFetch = DateTime.now();

            if (response.status == ResponseStatus.success) {
              agendaCache = response;
            }
          }
        }
        break;
      case Endpoint.appointments:
        {
          final lastFetchInMinutes =
              DateTime.now().difference(_lastAppointmentFetch).inMinutes;
          if (lastFetchInMinutes <= _settings.remoteServerRefreshTimeMinutes) {
            response = appointmentsCache;
          } else {
            response = await _server.fetchContent(endpoint);
            _lastAppointmentFetch = DateTime.now();

            if (response.status == ResponseStatus.success) {
              appointmentsCache = response;
            }
          }
        }
        break;
    }
    return response;
  }
}
