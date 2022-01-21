import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/infra/datasources/i_insert_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class InsertCardDataSource implements IInsertCardDataSource  {
  final ApiServerDataSource _server;

  InsertCardDataSource(this._server);

  @override
  Future<IResponse> call(EntryEntity entry, Endpoint endpoint) async {
    final content = entry.toMap();
    return await _server.postContent(endpoint, content);
  }
}
