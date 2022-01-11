import 'package:flutter_test/flutter_test.dart';
import 'package:zione/features/agenda/data/datasources/refresh_feed_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/domain/repositories/i_refresh_feed_repository.dart';
import 'package:zione/features/agenda/domain/usecases/i_refresh_feed_usecase.dart';
import 'package:zione/features/agenda/infra/datasources/i_refresh_feed_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/features/agenda/infra/repositories/refresh_feed_repository.dart';
import 'package:zione/utils/enums.dart';

import 'agenda_endpoint_json_response.dart';

main() {
  // test('Should return error when not able to connect with remote server', () {
  // });

  test('Should return list of appointments when refresh agenda endpoint', () async {
    final server = ApiServerDataSource();
    IRefreshFeedDataSouce datasource = RefreshFeedDataSource(server);
    IRefreshFeedRepository repository = RefreshFeedRepository(datasource);
    IRefreshFeedUsecase refresh = RefreshFeedUsecase(repository);

    IResponse response = await refresh(Endpoint.agenda);
    const Map<String, dynamic> responseExpected = responseMap;

    expect(response.result, responseExpected['Result']);
  });
}
