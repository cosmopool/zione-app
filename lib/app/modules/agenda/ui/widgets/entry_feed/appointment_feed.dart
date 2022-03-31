import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/appointment_store.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_card/appointment_card.dart';

class AppointmentsFeed extends StatefulWidget {
  const AppointmentsFeed({Key? key}) : super(key: key);

  @override
  _AppointmentsFeedState createState() => _AppointmentsFeedState();
}

class _AppointmentsFeedState extends State<AppointmentsFeed> {
  final store = Modular.get<AppointmentStore>();
  final tkStore = Modular.get<TicketStore>();

  @override
  void initState() {
    super.initState();
    tkStore.fetch();
    store.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
        store: store,
        onState: (context, List<AppointmentEntity> state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final appointment = state[index];
              final ticket = tkStore.getTicketById(appointment.ticketId);
              return AppointmentCard(appointment: appointment, ticket: ticket,);
            },
          );
        },
        onError: (context, error) => Text(error.toString()),
        onLoading: (context) => const CircularProgressIndicator());
  }
}
