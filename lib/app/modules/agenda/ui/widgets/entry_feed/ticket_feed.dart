import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_card/ticket_card.dart';

class TicketsFeed extends StatefulWidget {
  const TicketsFeed({Key? key}) : super(key: key);

  @override
  _TicketsFeedState createState() => _TicketsFeedState();
}

class _TicketsFeedState extends State<TicketsFeed> {
  final store = Modular.get<TicketStore>();

  @override
  void initState() {
    super.initState();
    store.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => store.fetch(),
      child: ScopedBuilder(
        store: store,
        onState: (context, List<TicketEntity> state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return TicketCard(ticket: state[index]);
            },
          );
        },
        onError: (context, error) => Text(error.toString()),
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
