import 'package:dartz/dartz.dart';
import 'package:zione/core/errors/failures.dart';
import 'package:zione/features/agenda/data/datasources/local/i_local_datasource.dart';
import 'package:zione/features/agenda/data/datasources/remote/i_remote_datasource.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/domain/repositories/i_ticket_repository.dart';

class TicketRepository implements ITicketRepository<bool, TicketEntity> {
  final IRemoteDatasource _api;
  final ILocalDatasource _cache;

  TicketRepository(this._api, this._cache);

  /// Close a open ticket
  @override
  Future<Either<Failure, List<Map>>> fetch(TicketEntity tk) async {
    late Failure failure;
    late List<Map> result;

    final response = await _api.fetchContent(tk.endpoint);
    response.fold((l) => failure = l, (r) => result = r);

    if (response.isRight()) {
      await _cache.postContentList(tk.endpoint, result);
      return right(result);
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
    return left(failure);
  }

  /// Close a open ticket
  @override
  Future<Either<Failure, bool>> close(TicketEntity tk) async {
    late Failure failure;
    bool result = false;

    final response = await _api.closeContent(tk.endpoint, tk.toMap());
    response.fold((l) => failure = l, (r) => result = r);

    if (response.isRight()) {
      final cacheRes = await _cache.closeContent(tk.endpoint, tk.toMap());
      cacheRes.fold((l) => failure = l, (r) => result = r);
      if (cacheRes.isRight()) {
        return right(result);
      }
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
    return left(failure);
  }

  @override
  Future<Either<Failure, bool>> delete(TicketEntity tk) async {
    late Failure failure;
    bool result = false;

    final response = await _api.deleteContent(tk.endpoint, tk.toMap());
    response.fold((l) => failure = l, (r) => result = r);

    if (response.isRight()) {
      final cacheRes = await _cache.deleteContent(tk.endpoint, tk.toMap());
      cacheRes.fold((l) => failure = l, (r) => result = r);
      if (cacheRes.isRight()) {
        return right(result);
      }
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
    return left(failure);
  }

  @override
  Future<Either<Failure, bool>> edit(TicketEntity tk) async {
    late Failure failure;
    bool result = false;

    final response = await _api.updateContent(tk.endpoint, tk.toMap());
    response.fold((l) => failure = l, (r) => result = r);

    if (response.isRight()) {
      final cacheRes = await _cache.updateContent(tk.endpoint, tk.toMap());
      cacheRes.fold((l) => failure = l, (r) => result = r);
      if (cacheRes.isRight()) {
        return right(result);
      }
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseTicketUsecase, tk); */
    return left(failure);
  }

  @override
  Future<Either<Failure, bool>> insert(TicketEntity tk) async {
    late Failure failure;
    bool result = false;

    final response = await _api.postContent(tk.endpoint, tk.toMap());
    response.fold((l) => failure = l, (r) => result = r);

    if (response.isRight()) {
      final cacheRes = await _cache.postContent(tk.endpoint, tk.toMap());
      cacheRes.fold((l) => failure = l, (r) => result = r);
      if (cacheRes.isRight()) {
        return right(result);
      }
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(postTicketUsecase, tk); */
    return left(failure);
  }
}
