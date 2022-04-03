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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ListTile(
              title: Text(
                RegExp(r'\d\d:\d\d').stringMatch(widget.appointment.time)!,
                style: TextStyle(
                  fontSize: _expanded ? 48 : 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
              trailing: _expanded
                  ? IconButton(
                      icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                      onPressed: () => showBottomAutoSizeModal(
                          context,
                          AppointmentCardMenu(
                            appointment: widget.appointment,
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
                  // trailing: const Icon(FontAwesomeIcons.phone),
                  trailing: IconButton(
                      onPressed: () =>
                          launcher.phone(widget.ticket.clientPhone),
                      icon: const Icon(FontAwesomeIcons.phone)),
                ),
                dividerTheme(),
                ListTile(
                  title: Text(widget.ticket.clientAddress),
                  subtitle: Text(widget.ticket.clientAddress),
                  // trailing: const Icon(Icons.location_on),
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
    );
  }
}
