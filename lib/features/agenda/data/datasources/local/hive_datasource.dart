import 'package:hive/hive.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/features/agenda/domain/entities/entry_entity.dart';
import 'package:zione/features/agenda/infra/datasources/i_response_api_request.dart';
import 'package:zione/utils/enums.dart';

import 'i_cache_datasource.dart';

class HiveDatasouce extends ICacheDatasource {
  Box _box;

  HiveDatasouce(this._box);

  @override
  Future<IResponse> fetchContent(Endpoint endpoint) async {
    final String boxKey = endpoint.name;
    final IResponse response =
        await _box.get(boxKey, defaultValue: Response.noConnection());
    return response;
  }

  @override
  Future<IResponse> saveContent(Endpoint endpoint, IResponse response) async {
    final String boxKey = endpoint.name;
    await _box.put(boxKey, response);
    final responseToReturn =
        Response.fromMap({'Status': 'Success', 'Result': 'Saved!'});

    return responseToReturn;
  }

  /// this will be used when the client tries to insert some entry
  /// but the api server is offline. The entry will be saved so
  /// the user don't loose data.
  ///
  /// Function that save content that needs to be sent to server
  /// when it gets back online
  @override
  Future<bool> saveToSyncContent(
      Endpoint endpoint, EntryEntity entry) async {
    final String boxKey = endpoint.name + "ToSync";
    print("boxKey 0------------------ \n $boxKey");
    var entryList = await _box.get(boxKey);
    print("entryList first ------------------- \n $entryList");
    if (entryList == null) {
      entryList = [entry];
    } else {
      entryList.add(entry);
    }

    print("entrylist final ------------------- \n $entryList");
    try {
      await _box.put(boxKey, entryList);
    } catch (e) {
      return false;
    }

    return true;
  }

  /// this will be used when the client tries to insert some entry
  /// but the api server is offline. The entry will be saved so
  /// the user don't loose data.
  ///
  /// Function that save content that needs to be sent to server
  /// when it gets back online
  @override
  Future<List> fetchToSyncContent(Endpoint endpoint) async {
    final String boxKey = endpoint.name + "ToSync";
    final List listEntries = await _box.get(boxKey, defaultValue: []);
    return listEntries;
  }
}
