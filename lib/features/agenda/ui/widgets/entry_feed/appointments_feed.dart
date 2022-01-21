import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zione/features/agenda/domain/entities/agenda_entry_entity.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/features/agenda/ui/widgets/entry_card/agenda_entry_card.dart';
import 'package:zione/features/agenda/ui/widgets/feed_section/feed_section.dart';
import 'package:zione/utils/enums.dart';

class AppointmentsFeed extends StatefulWidget {
  const AppointmentsFeed({Key? key}) : super(key: key);

  @override
  _AppointmentsFeedState createState() => _AppointmentsFeedState();
}

class _AppointmentsFeedState extends State<AppointmentsFeed> {
  late bool _isLoading;
  late Map _entriesByDate;

  @override
  void initState() {
    super.initState();
    context.read<FeedProvider>().refresh(Endpoint.agenda);
  }

  @override
  Widget build(BuildContext context) {
    _entriesByDate = context.watch<FeedProvider>().agendaEntryFeedByDate;
    _isLoading = context.watch<FeedProvider>().isLoading;
    final dates = _entriesByDate.keys.toList();

    AgendaEntryEntity classInstantiator(entryMap) => AgendaEntryEntity(entryMap);
    Widget cardInstantiator(entry) => AgendaEntryCard(entry: entry);

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              return FeedSection(
                date: date,
                entries: _entriesByDate[date],
                classInstantiator: classInstantiator,
                cardInstantiator: cardInstantiator,
              );
            },
          );
  }
}
