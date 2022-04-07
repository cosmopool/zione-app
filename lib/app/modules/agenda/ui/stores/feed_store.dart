import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';
part 'feed_store.g.dart';

class FeedStore = _FeedStore with _$FeedStore;

abstract class _FeedStore with Store {
  final log = Logger('FeedStore');
  final mainPageRoutes = ["/agenda", "/tickets"];

  @observable
  var dateToShow = DateTime.now();

  @observable
  var showCalendar = false;

  @observable
  var screenIndex = 0;

  @action
  void showDate(DateTime date) {
    log.info("[FEED][STORE] showing appointments from date: $date");
    dateToShow = date;
  }

  @action
  void navigateTo(int index) {
    log.info("[FEED][STORE] navigating to new screen: ${mainPageRoutes[index]}, with index: $index");
    Modular.to.navigate(mainPageRoutes[index]);
    screenIndex = index;
  }

  @action
  void switchCalendar() {
    log.info("[FEED][STORE] switching calendar visibility: ${!showCalendar}");
    showCalendar = !showCalendar;
  }
}
