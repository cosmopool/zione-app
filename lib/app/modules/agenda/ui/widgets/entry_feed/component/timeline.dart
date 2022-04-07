import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timelines/timelines.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_card/appointment_card.dart';

class AppointmentTimeline extends StatelessWidget {
  final List<AppointmentEntity> appointmentList;
  final store = Modular.get<TicketStore>();

  AppointmentTimeline({Key? key, required this.appointmentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Timeline.tileBuilder(
      padding: const EdgeInsets.only(left: 15),
      theme: TimelineThemeData(nodePosition: 0.0, indicatorPosition: .3),
      builder: TimelineTileBuilder.connected(
        itemCount: appointmentList.length,
        contentsBuilder: (context, index) {
          final appointment = appointmentList[index];
          final ticket = store.getTicketById(appointment.ticketId);
          return AppointmentCard(
            appointment: appointment,
            ticket: ticket,
          );
        },
        indicatorBuilder: (_, index) {
          final ap = appointmentList[index];
          return DotIndicator(
            color: ap.hasPassed
                ? theme.disabledColor
                : theme.colorScheme.primary,
          );
        },
        connectorBuilder: (_, index, __) {
          final ap = appointmentList[index];
          return SolidLineConnector(
            color: ap.hasPassed
                ? theme.disabledColor
                : theme.colorScheme.primary,
          );
        },
      ),
    );
  }
}
