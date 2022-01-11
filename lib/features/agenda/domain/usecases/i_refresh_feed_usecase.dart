import 'package:zione/features/agenda/domain/repositories/i_refresh_feed_repository.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

abstract class IRefreshFeedUsecase {
  Future<IResponse> call(Endpoint endpoint);
}

class RefreshFeedUsecase extends IRefreshFeedUsecase {
  final IRefreshFeedRepository _repository;

  RefreshFeedUsecase(this._repository);

  @override
  Future<IResponse> call(Endpoint endpoint) async {
    final result = await _repository(endpoint);
    return result;
  }
}
