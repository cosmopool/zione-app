import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_card/components/divider_theme.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_card/components/url_launcher.dart' as launcher;


class AppointmentCard extends StatefulWidget {
  AppointmentEntity appointment;

  AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  final store = Modular.get<TicketStore>();

  @override
  void initState() {
    super.initState();
    /* store.fetch(); */
  }

  bool _expanded = false;
  double borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: _expanded ? 15 : 20, vertical: _expanded ? 20 : 7.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListTile(
                title: Text(
                  widget.appointment.time,
                  style: TextStyle(
                    fontSize: _expanded ? 48 : 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                /* trailing: _expanded */
                /*     ? IconButton( */
                /*         icon: const Icon(FontAwesomeIcons.ellipsisV), */
                /*         // onPressed: () => {}, */
                /*         /* onPressed: () => showBottomAutoSizeModal( */ */
                /*         /*     context, CardMenu(widget.appointment, Endpoint.appointments)), */ */
                /*       ) */
                /*     : null, */
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            /* Visibility( */
            /*   visible: !_expanded, */
            /*   child: Padding( */
            /*     padding: const EdgeInsets.only(bottom: 20), */
            /*     child: Column( */
            /*       children: [ */
            /*         ListTile( */
            /*           title: Text(widget.appointment.clientAddress), */
            /*           subtitle: Text(widget.appointment.serviceType), */
            /*         ), */
            /*       ], */
            /*     ), */
            /*   ), */
            /* ), */
            /* Visibility( */
            /*   visible: _expanded, */
            /*   child: Column( */
            /*     children: [ */
            /*       dividerTheme(), */
            /*       ListTile( */
            /*         title: Text(widget.appointment.clientName), */
            /*         subtitle: Text(widget.appointment.serviceType), */
            /*         // trailing: const Icon(FontAwesomeIcons.phone), */
            /*         trailing: IconButton( */
            /*             onPressed: () => */
            /*                 launcher.phone(widget.appointment.clientPhone), */
            /*             icon: const Icon(FontAwesomeIcons.phone)), */
            /*       ), */
            /*       dividerTheme(), */
            /*       ListTile( */
            /*         title: Text(widget.appointment.clientAddress), */
            /*         subtitle: Text(widget.appointment.clientAddress), */
            /*         // trailing: const Icon(Icons.location_on), */
            /*         trailing: IconButton( */
            /*             onPressed: () => */
            /*                 launcher.maps(widget.appointment.clientAddress), */
            /*             icon: const Icon(FontAwesomeIcons.mapMarkerAlt)), */
            /*       ), */
            /*       dividerTheme(), */
            /*       Padding( */
            /*         padding: const EdgeInsets.only(bottom: 20), */
            /*         child: ListTile( */
            /*           title: Text(widget.appointment.description), */
            /*         ), */
            /*       ), */
                /* ], */
              /* ), */
            /* ), */
          ],
        ),
      ),
    );
  }
}
