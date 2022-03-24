import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/cache_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/core/utils/enums.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/i_local_datasource.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/i_remote_datasource.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_ticket_repository.dart';

class TicketRepository implements ITicketRepository<bool, TicketEntity> {
  final IRemoteDatasource _api;
  final ILocalDatasource _cache;
  final ISettings _settings;
  final endpoint = Endpoint.tickets;
  DateTime _lastFetch = DateTime.utc(1989, DateTime.november, 9);
  int _tryCount = 0;
  final log = Logger('TicketRepository');

  TicketRepository(this._api, this._cache, this._settings);

  /// Fetch content from cache
  Future<Either<Failure, List<Map>>> _fetchContentFromCache(
      int count, Failure? failure) async {
    late List<Map> result;

    if (count <= 0 && failure != null) {
      return Left(failure);
    } else {
      count--;
      final response = await _cache.fetchContent(endpoint);
      response.fold((l) => null, (r) => result = r);
      return response.isRight()
          ? Right(result)
          : await _api.fetchContent(endpoint);
    }
  }

  /// Set [_tryCount] to it's default value if is less then or equal 0
  Future<void> _setTryCount() async => _tryCount =
      _tryCount <= 0 ? await _settings.tryReconnectCount : _tryCount;

  /// Fetch all open tickets
  @override
  Future<Either<Failure, List<Map>>> fetch() async {
    late Failure failure;
    late List<Map> result;
    await _setTryCount();

    final lastFetchInMinutes = DateTime.now().difference(_lastFetch).inMinutes;

    if (lastFetchInMinutes > await _settings.remoteApiRefreshTimeMinutes) {
      final response = await _api.fetchContent(endpoint);
      response.fold((l) => failure = l, (r) => result = r);

      if (response.isRight()) {
        _lastFetch = DateTime.now();
        await _cache.postContentList(endpoint, result);
        return Right(result);
      } else if (failure == AuthTokenError() || failure == UnformattedResponse()) {
        return left(failure);
      } else {
        return _fetchContentFromCache(_tryCount, failure);
      }
    } else {
      // TODO: implement QueueRequestUsecase
      /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
      return _fetchContentFromCache(_tryCount, null);
    }
  }

  /// Close a open ticket
  @override
  Future<Either<Failure, bool>> close(TicketEntity tk) async {
    late Failure failure;

    final response = await _api.closeContent(endpoint, tk.toMap());
    response.fold((l) => failure = l, (r) => null);

    if (response.isRight()) {
      return await _cache.closeContent(endpoint, tk.toMap());
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
    return Left(failure);
  }

  @override
  Future<Either<Failure, bool>> delete(TicketEntity tk) async {
    late Failure failure;

    final response = await _api.deleteContent(endpoint, tk.toMap());
    response.fold((l) => failure = l, (r) => null);

    /* final idIsValid = await validateId(tk.id); */
    /* idIsValid.fold((l) => failure = l, (r) => null); */
    /**/
    /* if (response.isRight() && idIsValid.isRight()) { */
    if (response.isRight()) {
      return await _cache.deleteContent(endpoint, tk.toMap());
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
    return Left(failure);
  }

  @override
  Future<Either<Failure, bool>> edit(TicketEntity tk) async {
    late Failure failure;

    final response = await _api.updateContent(endpoint, tk.toMap());
    response.fold((l) => failure = l, (r) => null);

    /* final idIsValid = await validateId(tk.id); */
    /* idIsValid.fold((l) => failure = l, (r) => null); */

    /* if (response.isRight() && idIsValid.isRight()) { */
    if (response.isRight()) {
      return await _cache.updateContent(endpoint, tk.toMap());
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
    return Left(failure);
  }

  @override
  Future<Either<Failure, bool>> insert(TicketEntity tk) async {
    late Failure failure;

    final response = await _api.postContent(endpoint, tk.toMap());
    response.fold((l) => failure = l, (r) => null);

    if (response.isRight()) {
      return await _cache.postContent(endpoint, tk.toMap());
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(postTicketUsecase, tk); */
    return Left(failure);
  }

  Future<Either<Failure, bool>> validateId(int? id) async {
    late final List<Map> contentList;
    late final Failure failure;

    /* final int _id = int.parse(id ?? -1); */
    final int _id = id ?? -1;
    final list = await _cache.fetchContent(endpoint);
    list.fold((l) => failure = l, (r) => contentList = r);

    if (_id < 0) {
      return left(InvalidValue("{'id': $_id}"));
    } else if (list.isRight() && _id > -1 && _id >= contentList.length) {
      return left(EntryNotFound("{'id': $_id}"));
    } else if (list.isLeft()) {
      /* return left(EntryNotFound("{'id': $_id}")); */
      return left(failure);
    } else {
      return right(true);
    }
  }
}
