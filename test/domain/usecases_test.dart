import 'package:flutter_test/flutter_test.dart';
import 'package:zione/features/agenda/domain/usecases/i_close_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_delete_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_edit_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_insert_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_refresh_feed_usecase.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';

import 'usecases/close_card_usecase_test.dart';
import 'usecases/delete_card_usecase_test.dart';
import 'usecases/edit_card_usecase_test.dart';
import 'usecases/insert_card_usecase_test.dart';

main() {
  final IInsertCardUseCase _insert = InsertCardUseCaseTest();
  final ICloseCardUsecase _close = CloseCardUsecaseTest();
  final IDeleteCardUseCase _delete = DeleteCardUsecaseTest();
  final IEditCardUsecase _edit = EditCardUsecaseTest();
  final IRefreshFeedUsecase _refresh = RefreshFeedUsecase();
  final FeedProvider feedProvider = FeedProvider(_insert, _close, _edit, _delete, _refresh);
}
