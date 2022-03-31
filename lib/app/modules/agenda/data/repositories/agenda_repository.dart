import 'package:dartz/dartz.dart';
import 'package:zione/app/modules/agenda/data/datasources/local/i_local_datasource.dart';
import 'package:zione/app/modules/agenda/data/datasources/remote/i_remote_datasource.dart';
import 'package:zione/app/modules/agenda/data/mappers/agenda_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/agenda_entity.dart';
import 'package:zione/app/modules/agenda/domain/repositories/i_agenda_repository.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/core/utils/enums.dart';

class AgendaRepository implements IAgendaRepository<bool, AgendaEntity> {
  final IRemoteDatasource _api;
  final ILocalDatasource _cache;
  final endpoint = Endpoint.agenda;

  AgendaRepository(this._api, this._cache);

  @override
  Future<Either<Failure, bool>> insert(AgendaEntity entry) async {
    final response = await _api.postContent(endpoint, entry.toMap());

    if (response.isRight()) {
      final ap = AgendaMapper.toAppointment(entry);
      final tk = AgendaMapper.toTicket(entry);
      final cacheAp = await _cache.postContent(ap.endpoint, ap.toMap());
      final cacheTk = await _cache.postContent(tk.endpoint, tk.toMap());
      if (cacheAp.isLeft()) return cacheAp;
      if (cacheTk.isLeft()) return cacheTk;
      return response;
    } else {
      return response;
    }
  }
}
