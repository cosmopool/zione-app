import 'package:zione/utils/enums.dart';
import 'package:zione/features/agenda/domain/repositories/feed_repository_interface.dart';
import 'package:zione/features/agenda/domain/entities/entry_model.dart';
import 'package:zione/features/agenda/data/services/rest_api_service.dart';
import 'package:zione/features/agenda/data/models/rest_api_response_model.dart';

class FeedRepository extends FeedRepositoryInterface {
  final ApiRequests api;
  FeedRepository({required this.api});

  @override
  Future<ResponseStatus> fetch(Endpoint endpoint) async {
    final Response response = await api.fetchContentFromServer(endpoint);
    return response.status;
  }

  @override
  Future<ResponseStatus> insert(Endpoint endpoint, Entry entry) async {
    final entryToMap = entry.toMap();
    final Response response = await api.postContentToServer(endpoint, entryToMap);
    return response.status;
  }

  @override
  Future<ResponseStatus> delete(Endpoint endpoint, Entry entry) async {
    final entryToMap = entry.toMap();
    final Response response = await api.deleteContentFromServer(endpoint, entryToMap);
    return response.status;
  }
}
