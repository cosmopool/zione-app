import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';

import 'components/divider_theme.dart';
import 'components/url_launcher.dart' as launcher;

class AgendaEntryCard extends StatefulWidget {
  final AgendaEntryEntity entry;

  const AgendaEntryCard({Key? key, required this.entry}) : super(key: key);

  @override
  _EntryCardState createState() => _EntryCardState();
}

class _EntryCardState extends State<AgendaEntryCard> {
  bool expanded = false;
  double borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListTile(
                title: Text(
                  widget.entry.time,
                  style: TextStyle(
                    fontSize: expanded ? 50 : 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                // trailing: expanded ? const Icon(FontAwesomeIcons.ellipsisV) : null,
                trailing: expanded
                    ? IconButton(
                        icon: const Icon(FontAwesomeIcons.ellipsisV),
                        onPressed: ()=>{},
                        // onPressed: () => showBottomAutoSizeModal(context,
                        //     CardMenu("agendamento", null, widget.entry)),
                      )
                    : null,
                onTap: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
              ),
            ),
            Visibility(
              visible: !expanded,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(widget.entry.clientAddress),
                      subtitle: Text(widget.entry.serviceType),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: expanded,
              child: Column(
                children: [
                  dividerTheme(),
                  ListTile(
                    title: Text(widget.entry.clientName),
                    subtitle: Text(widget.entry.serviceType),
                    // trailing: const Icon(FontAwesomeIcons.phone),
                    trailing: IconButton(
                        onPressed: () => launcher.phone(widget.entry.clientPhone),
                        icon: const Icon(FontAwesomeIcons.phone)),
                  ),
                  dividerTheme(),
                  ListTile(
                    title: Text(widget.entry.clientAddress),
                    subtitle: Text(widget.entry.clientAddress),
                    // trailing: const Icon(Icons.location_on),
                    trailing: IconButton(
                        onPressed: () =>
                            launcher.maps(widget.entry.clientAddress),
                        icon: const Icon(FontAwesomeIcons.mapMarkerAlt)),
                  ),
                  dividerTheme(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      title: Text(widget.entry.description),
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
