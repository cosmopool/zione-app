import 'package:zione/features/agenda/data/datasources/local/i_cache_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/i_datasource.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/infra/datasources/i_insert_card_datasource.dart';
import 'package:zione/utils/enums.dart';

class InsertCardDataSource implements IInsertCardDataSource  {
  final IApiDatasource _server;
  final ICacheDatasource _cache;

  /* InsertCardDataSource(this._server); */
  InsertCardDataSource(this._server, this._cache);

  @override
  Future<bool> call(EntryEntity entry, Endpoint endpoint) async {
    late final bool result;
    final content = entry.toMap();
    final response = await _server.postContent(endpoint, content);

    /// if any error occured when posting content
    /// save content to cache so user do not loose any data
    if (response.status == ResponseStatus.err) {
      /* final bool didSaveInCache = await _cache.saveToSyncContent(endpoint, entry); */
      /* result = didSaveInCache; */
      result = false;
    } else {
      result = true;
    }
      return result;
  }
}
