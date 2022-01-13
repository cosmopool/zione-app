import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:zione/core/auth.dart';
import 'package:zione/core/dependency_injection.dart';
import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';
import 'package:zione/features/agenda/domain/usecases/i_close_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_delete_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_edit_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_insert_card_usecase.dart';
import 'package:zione/features/agenda/domain/usecases/i_refresh_feed_usecase.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/utils/enums.dart';

import '../../authorizarion_token_for_tests.dart';
import '../../domain/usecases/agenda_endpoint_json_response.dart';
import '../../domain/usecases/close_card_usecase_test.dart';
import '../../domain/usecases/delete_card_usecase_test.dart';
import '../../domain/usecases/edit_card_usecase_test.dart';
import '../../domain/usecases/insert_card_usecase_test.dart';
import '../../domain/usecases/refresh_feed_usecase_test.dart';

void main() {
  token = testToken;
  Inject.init();

  final IInsertCardUseCase _insert = InsertCardUseCaseTest();
  final ICloseCardUsecase _close = CloseCardUsecaseTest();
  final IDeleteCardUseCase _delete = DeleteCardUsecaseTest();
  final IEditCardUsecase _edit = EditCardUsecaseTest();
  final IRefreshFeedUsecase _refresh = RefreshFeedUsecaseTest();
  final FeedProvider feedProvider = FeedProvider(_insert, _close, _edit, _delete, _refresh);

  test('On refresh, should have a list with agenda entry instances', () {
    feedProvider.refresh(Endpoint.agenda);
    // expected value
    final List<AgendaEntryEntity> expected = [];
    responseForTests['Result'].forEach(
        (entry) => expected.add(AgendaEntryEntity(entry)));
    final actual = feedProvider.agendaEntryFeed;

    expect(actual[0].id, expected[0].id);
    expect(actual[1].id, expected[1].id);
    expect(actual[2].id, expected[2].id);
  });

  test('On refresh, should separate agenda entries by date', () {
    feedProvider.refresh(Endpoint.agenda);
    final actual = feedProvider.agendaEntryFeedByDate;
    final Map<String, List<AgendaEntryEntity>> expected = {
      '2021-01-12': [AgendaEntryEntity(responseForTests['Result'][0])],
      '2021-12-02': [AgendaEntryEntity(responseForTests['Result'][1])],
      '2021-12-09': [AgendaEntryEntity(responseForTests['Result'][2])]
    };

    final actualKeys = actual.keys;
    final expectedKeys = expected.keys;
    int actualEntriesLenght = 0;
    int expectedEntriesLenght = 0;

    actual.forEach((key, value) => actualEntriesLenght++);
    expected.forEach((key, value) => expectedEntriesLenght++);

    expect(actualKeys, expectedKeys);
    expect(actualEntriesLenght, expectedEntriesLenght);
  });

  test('Should insert entry given valid input', () {});
  test('Should close entry given valid input', () {});
  test('Should edit entry given valid input', () {
    final entry = AgendaEntryEntity(responseForTests['Result'][0]);
    feedProvider.delete(entry, Endpoint.agenda);

    expect(feedProvider.result, true);
  });

  test('Should delete entry on succeful response', () {
    final entry = AgendaEntryEntity(responseForTests['Result'][0]);
    feedProvider.delete(entry, Endpoint.agenda);

    expect(feedProvider.result, true);
  });
}
