import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_refresh_feed_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class RefreshFeedDataSource implements IRefreshFeedDataSouce  {
  final ApiServerDataSource _server;

  RefreshFeedDataSource(this._server);

  @override
  Future<IResponse> call(Endpoint endpoint) async {
    return await _server.fetchContentFromServer(endpoint);
  }
}
