import 'package:zione/utils/enums.dart';

abstract class IRefreshFeedRepository {
  Future<bool> call(Endpoint endpoint);
}
