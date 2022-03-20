import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zione/core/settings.dart';
import 'package:zione/features/agenda/data/datasources/close_card_datasource.dart';
import 'package:zione/features/agenda/data/datasources/delete_card_datasource.dart';
import 'package:zione/features/agenda/data/datasources/edit_card_datasource.dart';
import 'package:zione/features/agenda/data/datasources/insert_card_datasource.dart';
import 'package:zione/features/agenda/data/datasources/local/hive_datasource.dart';
import 'package:zione/features/agenda/data/datasources/local/i_cache_datasource.dart';
import 'package:zione/features/agenda/data/datasources/refresh_feed_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/i_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_datasource.dart';
import 'package:zione/features/agenda/data/datasources/rest_api_server/rest_api_response_model.dart';
import 'package:zione/features/agenda/domain/repositories/i_close_card_repository.dart';
import 'package:zione/features/agenda/domain/repositories/i_delete_card_repository.dart';
import 'package:zione/features/agenda/domain/repositories/i_edit_card_repository.dart';
import 'package:zione/features/agenda/domain/repositories/i_insert_card_repository.dart';
import 'package:zione/features/agenda/domain/repositories/i_refresh_feed_repository.dart';
import 'package:zione/features/agenda/domain/usecases/i_close_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_delete_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_edit_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_insert_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_refresh_feed_usecase.dart';
import 'package:zione/features/agenda/infra/datasources/i_close_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_delete_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_edit_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_insert_card_datasource.dart';
import 'package:zione/features/agenda/infra/datasources/i_refresh_feed_datasource.dart';
import 'package:zione/features/agenda/infra/repositories/close_card_repository.dart';
import 'package:zione/features/agenda/infra/repositories/delete_card_repository.dart';
import 'package:zione/features/agenda/infra/repositories/edit_card_repository.dart';
import 'package:zione/features/agenda/infra/repositories/insert_card_repository.dart';
import 'package:zione/features/agenda/infra/repositories/refresh_feed_repository.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/utils/enums.dart';

class Inject {
  static Future<void> init() async {
    GetIt getIt = GetIt.instance;

    await Hive.initFlutter();
    Hive.registerAdapter(ResponseStatusAdapter());
    Hive.registerAdapter(ResponseAdapter());
    var box = await Hive.openBox('contentCacheBox');

    // data
    getIt.registerSingleton<IApiDatasource>(ApiServerDataSource());
    getIt.registerSingleton<ICacheDatasource>(HiveDatasouce(box));

    // settings
    getIt.registerSingleton<Settings>(Settings());

    // datasources
    getIt.registerLazySingleton<ICloseCardDataSouce>(() => CloseCardDataSource(getIt()));
    getIt.registerLazySingleton<IInsertCardDataSource>(() => InsertCardDataSource(getIt(), getIt()));
    /* getIt.registerLazySingleton<IInsertCardDataSource>(() => InsertCardDataSource(getIt(), getIt())); */
    getIt.registerLazySingleton<IEditCardDataSouce>(() => EditCardDataSource(getIt()));
    getIt.registerLazySingleton<IDeleteCardDataSouce>(() => DeleteCardDataSource(getIt()));
    getIt.registerLazySingleton<IRefreshFeedDataSouce>(() => RefreshFeedDataSource(getIt(), getIt(), getIt()));

    // repositories
    getIt.registerLazySingleton<ICloseCardRepository>(() => CloseCardRepository(getIt()));
    getIt.registerLazySingleton<IInsertCardRepository>(() => InsertCardRepository(getIt()));
    getIt.registerLazySingleton<IEditCardRepository>(() => EditCardRepository(getIt()));
    getIt.registerLazySingleton<IDeleteCardRepository>(() => DeleteCardRepository(getIt()));
    getIt.registerLazySingleton<IRefreshFeedRepository>(() => RefreshFeedRepository(getIt()));

    // usecases
    getIt.registerLazySingleton<ICloseCardUsecase>(() => CloseCardUsecase(getIt()));
    getIt.registerLazySingleton<IInsertCardUseCase>(() => InsertCardUseCase(getIt()));
    getIt.registerLazySingleton<IEditCardUsecase>(() => EditCardUsecase(getIt()));
    getIt.registerLazySingleton<IDeleteCardUseCase>(() => DeleteCardUseCase(getIt()));
    getIt.registerLazySingleton<IRefreshFeedUsecase>(() => RefreshFeedUsecase(getIt()));

    // feed
    getIt.registerLazySingleton<IFeedProvider>(() => FeedProvider(getIt(), getIt(), getIt(), getIt(), getIt()));
    getIt.registerLazySingleton<FeedProvider>(() => FeedProvider(getIt(), getIt(), getIt(), getIt(), getIt()));
  }
}
