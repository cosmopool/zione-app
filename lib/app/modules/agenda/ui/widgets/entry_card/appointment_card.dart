import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/bottom_modal/bottom_modal.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_card/components/appointment_card_menu.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_card/components/divider_theme.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_card/components/url_launcher.dart'
    as launcher;

class AppointmentCard extends StatefulWidget {
  AppointmentEntity appointment;
  TicketEntity ticket;

  AppointmentCard({Key? key, required this.appointment, required this.ticket})
      : super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  final store = Modular.get<TicketStore>();

  @override
  void initState() {
    super.initState();
  }

  bool _expanded = false;
  double borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    final appointment = widget.appointment;

    return Opacity(
      opacity: (appointment.hasPassed && _expanded == false) ? 0.5 : 1,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      appointment.time,
                      style: TextStyle(
                        fontSize: _expanded ? 58 : 50,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        '~ ${appointment.finalTime}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                trailing: _expanded
                    ? IconButton(
                        icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                        onPressed: () => showBottomAutoSizeModal(
                            context,
                            AppointmentCardMenu(
                              appointment: appointment,
                            )),
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            Visibility(
              visible: !_expanded,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(widget.ticket.clientAddress),
                      subtitle: Text(widget.ticket.serviceType),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _expanded,
              child: Column(
                children: [
                  dividerTheme(),
                  ListTile(
                    title: Text(widget.ticket.clientName),
                    subtitle: Text(widget.ticket.serviceType),
                    trailing: IconButton(
                        onPressed: () =>
                            launcher.phone(widget.ticket.clientPhone),
                        icon: const Icon(FontAwesomeIcons.phone)),
                  ),
                  dividerTheme(),
                  ListTile(
                    title: Text(widget.ticket.clientAddress),
                    subtitle: Text(widget.ticket.clientAddress),
                    trailing: IconButton(
                        onPressed: () =>
                            launcher.maps(widget.ticket.clientAddress),
                        icon: const Icon(FontAwesomeIcons.locationDot)),
                  ),
                  dividerTheme(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      title: Text(widget.ticket.description),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
