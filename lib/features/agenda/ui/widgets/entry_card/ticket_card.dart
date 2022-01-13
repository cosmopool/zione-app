import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/features/agenda/domain/entities/ticket_entity.dart';
import 'package:zione/features/agenda/ui/widgets/entry_card/components/divider_theme.dart';
import 'package:zione/features/agenda/ui/widgets/entry_card/components/url_launcher.dart' as launcher;

class TicketCard extends StatefulWidget {
  final TicketEntity ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
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
                  widget.ticket.clientName,
                  style: TextStyle(
                    fontSize: _expanded ? 48 : 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                trailing: _expanded
                    ? IconButton(
                        icon: const Icon(FontAwesomeIcons.ellipsisV),
                        onPressed: () => {},
                        // onPressed: () => showBottomAutoSizeModal(
                        //     context, CardMenu("chamado", widget.ticket, null)),
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
                        icon: const Icon(FontAwesomeIcons.mapMarkerAlt)),
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
