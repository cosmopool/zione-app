import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/infra/datasources/i_close_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

class CloseCardDataSource implements ICloseCardDataSouce  {
  final ApiServerDataSource _server;

  CloseCardDataSource(this._server);

  @override
  Future<IResponse> call(EntryEntity entry, Endpoint endpoint) async {
    final content = entry.toMap();
    return await _server.closeContentFromServer(endpoint, content);
  }
}
