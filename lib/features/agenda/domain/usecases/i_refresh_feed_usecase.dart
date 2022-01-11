import 'package:zione/utils/enums.dart';

abstract class IRefreshFeedUsecase {
  Future<bool> call(Endpoint endpoint);
}

class RefreshFeedUsecase extends IRefreshFeedUsecase {}
