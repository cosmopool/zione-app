import 'package:flutter/material.dart';

import 'components/date_flag.dart';

class FeedSection extends StatefulWidget {
  final String date;
  final List entries;
  // classInstantiator:
  // function that receives E and return TicketEtity(E),
  // AgendaEntryEntity(E) or AppoitnmentEntity(E)
  final classInstantiator;
  // cardInstantiator:
  // function that receives E and return TicketCard(E),
  // AgendaEntryCard(E), or AppoitnmentCard(E)
  final cardInstantiator;
  const FeedSection(
      {Key? key,
      required this.date,
      required this.entries,
      required this.classInstantiator,
      required this.cardInstantiator})
      : super(key: key);

  @override
  _FeedSectionState createState() => _FeedSectionState();
}

class _FeedSectionState extends State<FeedSection> {
  @override
  Widget build(BuildContext context) {
    List<Widget> getSectionList() {
      List<Widget> list = [];

      list.add(DateFlag(dateString: widget.date));

      for (var entryMap in widget.entries) {
        list.add(widget.cardInstantiator(entryMap));
      }

      return list;
    }

    return Column(
      children: getSectionList(),
    );
  }
}
