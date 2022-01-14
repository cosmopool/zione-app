import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zione/features/agenda/ui/providers/feed_provider.dart';
import 'package:zione/features/agenda/ui/widgets/entry_card/ticket_card.dart';
import 'package:zione/utils/enums.dart';

class TicketsFeed extends StatefulWidget {
  const TicketsFeed({Key? key}) : super(key: key);

  @override
  _TicketsFeedState createState() => _TicketsFeedState();
}

class _TicketsFeedState extends State<TicketsFeed> {
  late List _contentList;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    context.read<FeedProvider>().refresh(Endpoint.tickets);
  }

  @override
  Widget build(BuildContext context) {
    _contentList = context.watch<FeedProvider>().ticketFeed;
    _isLoading = context.watch<FeedProvider>().isLoading;

    // return (_contentList != [] || _isLoading)
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _contentList.length,
            itemBuilder: (context, index) {
              return TicketCard(ticket: _contentList[index]);
            },
          );
  }
}

