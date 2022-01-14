import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/features/agenda/ui/widgets/entry_card/agenda_entry_card.dart';
import 'package:zione/utils/enums.dart';

class AppointmentsFeed extends StatefulWidget {
  const AppointmentsFeed({Key? key}) : super(key: key);

  @override
  _AppointmentsFeedState createState() => _AppointmentsFeedState();
}

class _AppointmentsFeedState extends State<AppointmentsFeed> {
  late List _contentList;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    context.read<FeedProvider>().refresh(Endpoint.agenda);
  }

  @override
  Widget build(BuildContext context) {
    _contentList = context.watch<FeedProvider>().agendaEntryFeed;
    _isLoading = context.watch<FeedProvider>().isLoading;

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _contentList.length,
            itemBuilder: (context, index) {
              return AgendaEntryCard(entry: _contentList[index]);
            },
          );
  }
}

