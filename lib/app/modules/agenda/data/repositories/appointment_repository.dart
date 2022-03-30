import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/i_local_datasource.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/i_remote_datasource.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_appointment_repository.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/settings.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

class AppointmentRepository
    implements IAppointmentRepository<bool, AppointmentEntity> {
  final IRemoteDatasource _api;
  final ILocalDatasource _cache;
  final ISettings _settings;
  final endpoint = Endpoint.appointments;
  DateTime _lastFetch = DateTime.utc(1989, DateTime.november, 9);
  int _tryCount = 0;
  final log = Logger('AppointmentRepository');

  AppointmentRepository(this._api, this._cache, this._settings);

  /// Fetch content from cache
  Future<Either<Failure, List<Map>>> _fetchContentFromCache(
      int count, Failure? failure) async {
    late List<Map> result;

    if (count <= 0) {
      return Left(NoConnectionWithServer());
    } else if (failure != null) {
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
      } else {
        return _fetchContentFromCache(_tryCount, failure);
      }
    } else {
      // TODO: implement QueueRequestUsecase
      /* await QueueRequestUsecase(CloseAppointmentUsecase, ap); */
      return _fetchContentFromCache(_tryCount, null);
    }
  }

  /// Close a open ticket
  @override
  Future<Either<Failure, bool>> close(AppointmentEntity ap) async {
    late Failure failure;

    final response = await _api.closeContent(endpoint, ap.toMap());
    response.fold((l) => failure = l, (r) => null);

    if (response.isRight()) {
      return await _cache.closeContent(endpoint, ap.toMap());
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseAppointmentUsecase, ap); */
    return Left(failure);
  }

  @override
  Future<Either<Failure, bool>> delete(AppointmentEntity ap) async {
    late Failure failure;

    final response = await _api.deleteContent(endpoint, ap.toMap());
    response.fold((l) => failure = l, (r) => null);

    /* final idIsValid = await validateId(ap.id); */
    /* idIsValid.fold((l) => failure = l, (r) => null); */
    /**/
    /* if (response.isRight() && idIsValid.isRight()) { */
    if (response.isRight()) {
      return await _cache.deleteContent(endpoint, ap.toMap());
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseAppointmentUsecase, ap); */
    return Left(failure);
  }

  @override
  Future<Either<Failure, bool>> edit(AppointmentEntity ap) async {
    late Failure failure;

    final response = await _api.updateContent(endpoint, ap.toMap());
    response.fold((l) => failure = l, (r) => null);

    /* final idIsValid = await validateId(ap.id); */
    /* idIsValid.fold((l) => failure = l, (r) => null); */

    /* if (response.isRight() && idIsValid.isRight()) { */
    if (response.isRight()) {
      return await _cache.updateContent(endpoint, ap.toMap());
    }
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(CloseAppointmentUsecase, ap); */
    return Left(failure);
  }

  @override
  Future<Either<Failure, bool>> insert(AppointmentEntity ap) async {
    /* late Failure failure; */

    final response = await _api.postContent(endpoint, ap.toMap());

    if (response.isRight()) {
      return await _cache.postContent(endpoint, ap.toMap());
    } else {
    // TODO: implement QueueRequestUsecase
    /* await QueueRequestUsecase(postAppointmentUsecase, ap); */
      return response;
    }
  }
}
