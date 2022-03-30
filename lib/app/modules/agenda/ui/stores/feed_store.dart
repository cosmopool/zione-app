import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';
import 'package:zione/app/modules/agenda/data/mappers/ticket_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_tickets_usecase.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStore with _$FeedStore;

abstract class _FeedStore with Store {
  final FetchTicketsUsecase _usecase;
  final log = Logger('FeedStore');
  _FeedStore(this._usecase);

  @observable
  bool loading = false;

  @observable
  Failure failure = NoFailure();

  @observable
  List<TicketEntity> tickets = [];

  @action
  Future<void> fetchTickets() async {
    log.info("[FEED][STORE] -- FETCHING TICKETS...");
    loading = true;
    failure = NoFailure();

    final res = await _usecase();

    res.fold((l) {
      failure = l;
      log.info("[FEED][STORE] a failure occured");
    }, (r) {
      tickets = TicketMapper.fromMapList(r);
    });

    if (failure == UnformattedResponse()) Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);

    loading = false;
  }
}
