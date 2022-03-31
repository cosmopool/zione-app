import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:logging/logging.dart';
import 'package:zione/app/modules/agenda/data/mappers/ticket_mapper.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/domain/usecases/close_ticket_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/delete_ticket_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/edit_ticket_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/fetch_tickets_usecase.dart';
import 'package:zione/app/modules/agenda/domain/usecases/insert_ticket_usecase.dart';
import 'package:zione/app/modules/core/errors/api_errors.dart';
import 'package:zione/app/modules/core/errors/failures.dart';

class TicketStore extends NotifierStore<Failure, List<TicketEntity>> {
  final FetchTicketsUsecase fetchUsecase;
  final InsertTicketUsecase insertUsecase;
  final DeleteTicketUsecase deleteUsecase;
  final CloseTicketUsecase closeUsecase;
  final EditTicketUsecase editUsecase;
  final log = Logger('TicketStore');
  List<TicketEntity> ticketList = [];

  TicketStore(
    this.fetchUsecase,
    this.insertUsecase,
    this.deleteUsecase,
    this.closeUsecase,
    this.editUsecase,
  ) : super([]);

  /// Fetch list of tickets
  ///
  /// User is redirect to login if token is expired
  /// or does not exist.
  ///
  /// If response is ok, set [ticketList] and [setState]
  Future<void> fetch() async {
    log.info("[FEED][STORE] -- FETCHING TICKETS...");
    setLoading(true);

    final list = await fetchUsecase();
    list.fold((failure) {
      log.info("[FEED][STORE] a failure occured");
      if (failure == AuthTokenError()) {
        Modular.to.pushNamedAndRemoveUntil('/login/', (_) => false);
      }
      setError(failure);
    }, (list) {
      final result = TicketMapper.fromMapList(list);
      ticketList = result;
      update(result);
    });

    setLoading(false);
  }

  /// Insert a given ticket
  Future<void> insert(TicketEntity tk) async {
    setLoading(true);
    final result = await insertUsecase(tk);
    result.fold((l) => setError(l), (r) => fetch());
    setLoading(false);
  }

  /// Delete a given ticket
  Future<void> delete(TicketEntity tk) async {
    setLoading(true);
    final result = await deleteUsecase(tk);
    result.fold((l) => setError(l), (r) => fetch());
    setLoading(false);
  }

  /// Close a given ticket
  Future<void> close(TicketEntity tk) async {
    setLoading(true);
    final result = await closeUsecase(tk);
    result.fold((l) => setError(l), (r) => fetch());
    setLoading(false);
  }

  /// Edit a given ticket
  Future<void> edit(TicketEntity tk) async {
    setLoading(true);
    final result = await editUsecase(tk);
    result.fold((l) => setError(l), (r) => fetch());
    setLoading(false);
  }

  /// Return a ticket whith given [id] from [ticketList]
  /// 
  /// If no ticket is found, return a "Not availabe" ticket
  /// instance: 
  ///
  ///  TicketEntity(
  ///      clientName: "Not availabe",
  ///      clientPhone: "Not availabe",
  ///      clientAddress: "Not availabe",
  ///      serviceType: "Not availabe",
  ///      description: "Not availabe",
  ///  )
  TicketEntity getTicketById(int id) => ticketList.firstWhere(
        (ticket) => ticket.id == id,
        orElse: () => TicketEntity(
          clientName: "Not availabe",
          clientPhone: "Not availabe",
          clientAddress: "Not availabe",
          serviceType: "Not availabe",
          description: "Not availabe",
        ),
      );
}
