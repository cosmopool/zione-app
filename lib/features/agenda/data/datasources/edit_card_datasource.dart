import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/infra/datasources/i_edit_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class EditCardDataSource implements IEditCardDataSouce  {
  final ApiServerDataSource _server;

  EditCardDataSource(this._server);

  @override
  Future<IResponse> call(EntryEntity entry, Endpoint endpoint) async {
    final content = entry.toMap();
    return await _server.updateContent(endpoint, content);
  }
}
