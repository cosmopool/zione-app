import 'package:zione/features/agenda/data/datasources/rest_api_server/i_datasource.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/infra/datasources/i_edit_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';

class EditCardDataSource implements IEditCardDataSouce  {
  final IApiDatasource _server;

  EditCardDataSource(this._server);

  @override
  Future<IResponse> call(EntryEntity entry) async {
    final endpoint = entry.endpoint;
    final content = entry.toMap();
    return await _server.updateContent(endpoint, content);
  }
}
