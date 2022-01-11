import 'package:zione/features/agenda/domain/repositories/i_refresh_feed_repository.dart';
import 'package:zione/features/agenda/infra/datasources/i_refresh_feed_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class RefreshFeedRepository implements IRefreshFeedRepository {
  final IRefreshFeedDataSouce _datasource;

  RefreshFeedRepository(this._datasource);

  @override
  Future<bool> call(Endpoint endpoint) async {
    bool result = false;

    // TODO: check if it will request cache or rest api
    final IResponse response = await _datasource(endpoint);
    (response.status == ResponseStatus.success) ? result = true : result = false;

    return result;
  }
}
