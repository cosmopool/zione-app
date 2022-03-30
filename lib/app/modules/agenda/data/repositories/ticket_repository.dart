import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/i_local_datasource.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/i_remote_datasource.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_ticket_repository.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

class TicketRepository implements ITicketRepository<bool, TicketEntity> {
  final IRemoteDatasource _api;
  final ILocalDatasource _cache;
  final ISettings _settings;
  final endpoint = Endpoint.tickets;
  DateTime _lastFetch = DateTime.utc(1989, DateTime.november, 9);
  final log = Logger('TicketRepository');

  TicketRepository(this._api, this._cache, this._settings);

  /// Fetch content from cache
  Future<Either<Failure, List<Map>>> _fetchContentFromCache(
      Failure? failure) async {
    final response = await _cache.fetchContent(endpoint);
    if (response.isLeft() && failure != null) {
      return left(failure);
    } else {
      return response;
    }
  }

  /// Fetch all open tickets
  @override
  Future<Either<Failure, List<Map>>> fetch() async {
    late Failure failure;
    late List<Map> result;
    /* await _setTryCount(); */

    final lastFetchInMinutes = DateTime.now().difference(_lastFetch).inMinutes;

    if (lastFetchInMinutes > await _settings.remoteApiRefreshTimeMinutes) {
      final response = await _api.fetchContent(endpoint);
      response.fold((l) => failure = l, (r) => result = r);

      if (response.isRight()) {
        _lastFetch = DateTime.now();
        await _cache.postContentList(endpoint, result);
        return right(result);
      } else if (failure == AuthTokenError() ||
          failure == UnformattedResponse()) {
        return left(failure);
      } else {
        return _fetchContentFromCache(failure);
      }
    } else {
      // TODO: implement QueueRequestUsecase
      /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
      return _fetchContentFromCache(null);
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
}
