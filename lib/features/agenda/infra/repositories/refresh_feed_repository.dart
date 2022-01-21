import 'package:zione/core/settings.dart';
import 'package:zione/features/agenda/data/datasources/local/cache_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/features/agenda/domain/repositories/i_refresh_feed_repository.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class RefreshFeedRepository implements IRefreshFeedRepository {
  final ApiServerDataSource _server;
  final ICacheDatasource _cache;
  final Settings _settings;
  DateTime _lastFetch = DateTime.utc(1989, DateTime.november, 9);

  RefreshFeedRepository(this._server, this._cache, this._settings);

  @override
  Future<IResponse> call(Endpoint endpoint) async {
    late final IResponse response;
    final lastFetchInMinutes = _lastFetch.difference(DateTime.now()).inMinutes;

    if (lastFetchInMinutes <= _settings.remoteServerRefreshTimeMinutes) {
      final list = _cache.fetchContent();
      response = Response({'Status': 'Success', 'Result': list});
    } else {
      response = await _server.fetchContent(endpoint);
      _lastFetch = DateTime.now();

      if (response.status == ResponseStatus.success) {
        _cache.saveContent(response.result);
      }
    }

    return response;
  }
}
