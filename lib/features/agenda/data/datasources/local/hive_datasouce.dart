import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:zione/core/errors/cache_errors.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/core/utils/enums.dart';
import 'package:zione/features/agenda/data/datasources/local/i_local_datasource.dart';

class HiveDatasouce extends ILocalDatasource {
  Box _box;

  HiveDatasouce(this._box);
  final log = Logger('HiveDatasource');

  @override
  Future<Either<Failure, List<Map>>> fetchContent(Endpoint endpoint) async {
    final String boxKey = endpoint.name;
    final List<Map>? contentList = await _box.get(boxKey, defaultValue: null);

    return contentList == null
        ? left(EmptyResponseFromCache())
        : right(contentList);
  }

  @override
  Future<Either<Failure, bool>> closeContent(
      Endpoint endpoint, Map content) async {
    final id = content['id'];

    Future<Either<Failure, bool>> _closeContent(List<Map> contentList) async {
      for (Map entry in contentList) {
        if (entry['id'] == id) {
          entry['isFinished'] = true;
          await _box.put(endpoint.name, contentList);
          return right(true);
        }
      }
      return left(EntryNotFound("{id: $id}"));
    }

    return handleFetchErrors(endpoint, (a) => _closeContent(a));
  }

  @override
  Future<Either<Failure, bool>> deleteContent(
      Endpoint endpoint, Map content) async {
    Future<Either<Failure, bool>> _deleteContent(List<Map> contentList) async {
      final didRemove = contentList.remove(content);
      log.fine("[CACHE][DELETE] did remove: $didRemove");

      log.finest("[CACHE][DELETE] saving current list: $contentList");
      if (didRemove) {
        postContentList(endpoint, contentList);
        return right(true);
      } else {
        log.severe("[CACHE][DELTE] could not found entry given: $content");
        return left(EntryNotFound("{id: $id}"));
      }
    }

    return handleFetchErrors(endpoint, (list) => _deleteContent(list));
  }

  @override
  Future<Either<Failure, bool>> postContent(
      Endpoint endpoint, Map content) async {
    log.info("[CACHE][POST] posting saving in: ${endpoint.name} box");
    log.finer("[CACHE][POST] entry to save: $content");

    List<Map>? contentList = await _box.get(endpoint.name);
    contentList?.add(content);
    log.info("[CACHE][POST] adding new content on list");
    await _box.put(endpoint.name, contentList ?? [content]);

    log.info("[CACHE][POST] checking if value was saved");
    List<Map>? newContentList = await _box.get(endpoint.name);

    if (newContentList != null && newContentList.contains(content)) {
      return right(true);
    } else {
      return left(NotAbleToSaveContent());
    }
  }

  @override
  Future<Either<Failure, bool>> updateContent(
      Endpoint endpoint, Map content) async {
    log.info("[CACHE][UPTADE] posting saving in: ${endpoint.name} box");
    log.finer("[CACHE][UPTADE] entry to save: $content");

    List<Map>? contentList = await _box.get(endpoint.name);
    log.info("[CACHE][UPTADE] updating new content on list");
    contentList?.forEach((element) {
      if (element['id'] == content['id']) element = content;
    });

    log.info("[CACHE][UPTADE] updating new content on list");
    await _box.put(endpoint.name, contentList ?? [content]);

    log.info("[CACHE][UPTADE] checking if value was saved");
    List<Map>? newContentList = await _box.get(endpoint.name);

    if (newContentList != null && newContentList.contains(content)) {
      return right(true);
    } else {
      return left(NotAbleToUpdateContent());
    }
  }

  @override
  Future<void> postContentList(Endpoint endpoint, List<Map> contentList) async {
    log.info("[CACHE][POST][LIST] saving list in: ${endpoint.name} box");
    log.finest("[CACHE][POST][LIST] list to save: $contentList");
    await _box.put(endpoint.name, contentList);
  }

  Future<Either<Failure, bool>> handleFetchErrors(Endpoint endpoint,
      Future<Either<Failure, bool>> Function(List<Map> list) callback) async {
    final fetchResponse = await fetchContent(endpoint);
    late List<Map> contentList;
    Failure? failure;

    fetchResponse.fold((l) => failure = l, (r) => contentList = r);

    if (failure == null) {
      log.finest("[CACHE][FETCH] content list: $contentList");
      return await callback(contentList);

    } else {
      log.severe(
          "[CACHE][FETCH] error occurred when fetching content from cache $failure");
      return left(failure!);
    }
  }
}
