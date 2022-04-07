import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:zione/app/modules/agenda/domain/entities/appointment_entity.dart';
import 'package:zione/app/modules/agenda/ui/stores/appointment_store.dart';
import 'package:zione/app/modules/agenda/ui/stores/feed_store.dart';
import 'package:zione/app/modules/agenda/ui/stores/ticket_store.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_feed/component/date_flag.dart';
import 'package:zione/app/modules/agenda/ui/widgets/entry_feed/component/timeline.dart';
import 'package:zione/app/modules/core/extensions/datetime_extension.dart';

class AppointmentsFeed extends StatefulWidget {
  const AppointmentsFeed({Key? key}) : super(key: key);

  @override
  _AppointmentsFeedState createState() => _AppointmentsFeedState();
}

class _AppointmentsFeedState extends State<AppointmentsFeed> {
  final store = Modular.get<AppointmentStore>();
  final tkStore = Modular.get<TicketStore>();
  final feed = Modular.get<FeedStore>();

  @override
  void initState() {
    super.initState();
    tkStore.fetch();
    store.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => store.fetch(),
      child: ScopedBuilder(
        store: store,
        onState: (context, List<AppointmentEntity> state) {
          final appointmentsByDate = store.byDate(state);
          appointmentsByDate.forEach(
            (key, value) => value.sort((a, b) => a.time.compareTo(b.time)),
          );
          return Column(
            children: [
              DateFlag(),
              AppointmentTimeline(
                appointmentList: appointmentsByDate[feed.dateToShow.dateOnly] ?? [],
              )
            ],
          );
        },
        onError: (context, error) => Text(error.toString()),
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
