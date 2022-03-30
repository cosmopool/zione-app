import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_tickets_usecase.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:zione/app/modules/agenda/data/mappers/ticket_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

class TicketStore extends NotifierStore<Failure, List<TicketEntity>> {
  final FetchTicketsUsecase _usecase;
  final log = Logger('TicketStore');

  TicketStore(this._usecase) : super([]);

  Future<void> fetch() async {
    log.info("[FEED][STORE] -- FETCHING TICKETS...");
    setLoading(true);

    final list = await _usecase();
    list.fold((failure) {
      log.info("[FEED][STORE] a failure occured");
      if (failure == AuthTokenError()) {
        Modular.to.pushNamedAndRemoveUntil('/login/', (_) => false);
      }
      setError(failure);
    }, (ticketList) {
      final result = TicketMapper.fromMapList(ticketList);
      update(result);
    });

    setLoading(false);
  }
}
