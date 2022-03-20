import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

abstract class ICacheDatasource {
  Future<IResponse> saveContent(Endpoint endpoint, IResponse response);
  Future<IResponse> fetchContent(Endpoint endpoint);
  Future<bool> saveToSyncContent(Endpoint endpoint, EntryEntity entry);
  Future<List> fetchToSyncContent(Endpoint endpoint);
}
