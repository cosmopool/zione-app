import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:zione/core/auth.dart';
import 'package:zione/core/dependency_injection.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/features/agenda/domain/usecases/i_refresh_feed_usecase.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

import '../../authorizarion_token_for_tests.dart';
import 'agenda_endpoint_json_response.dart';

main() {
  token = testToken;
  Inject.init();

  test('Should return list of appointments when refresh agenda endpoint', () async {
    final IRefreshFeedUsecase _refresh = GetIt.instance.get<IRefreshFeedUsecase>();

    IResponse response = await _refresh(Endpoint.agenda);
    const Map<String, dynamic> responseExpected = responseForTests;

    expect(response.result, responseExpected['Result']);
  });
}
