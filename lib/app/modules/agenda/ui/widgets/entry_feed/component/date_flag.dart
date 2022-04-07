import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zione/app/modules/agenda/ui/stores/appointment_store.dart';
import 'package:zione/app/modules/agenda/ui/stores/feed_store.dart';
import 'package:zione/app/modules/core/extensions/datetime_extension.dart';

class DateFlag extends StatelessWidget {
  final store = Modular.get<FeedStore>();
  final appointments = Modular.get<AppointmentStore>();

  DateFlag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final day = store.dateToShow.day.toString();
    final String weekday = store.dateToShow.weekdayToString();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final sizeConstant = MediaQuery.of(context).size.width / 5.5;
    final theme = Theme.of(context);
    const animationDuration = 300;

    return Observer(
      builder: (_) => Column(
        children: [
          GestureDetector(
            onTap: () => store.switchCalendar(),
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                store.showDate(
                    store.dateToShow.subtract(const Duration(days: 1)));
                appointments.fetch();
              }
              if (details.primaryVelocity! < 0) {
                store.showDate(store.dateToShow.add(const Duration(days: 1)));
                appointments.fetch();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: animationDuration),
              height: sizeConstant,
              decoration: BoxDecoration(
                color: ElevationOverlay.colorWithOverlay(
                  colorScheme.surface,
                  colorScheme.onSurface,
                  3.0,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(store.showCalendar ? 0 : 10),
                  bottomRight: Radius.circular(store.showCalendar ? 0 : 10),
                ),
              ),
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Observer(builder: (_) {
                    return Text(
                      store.dateToShow
                          .monthToString()
                          .toLowerCase()
                          .substring(0, 3),
                      style: theme.textTheme.bodyLarge,
                    );
                  }),
                  UnconstrainedBox(
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      height: sizeConstant * 1.4,
                      width: sizeConstant * 1.4,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: store.showCalendar
                              ? null
                              : theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          day,
                          style: theme.textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    weekday.toLowerCase(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: animationDuration + 100),
            curve: Curves.easeInOutQuad,
            opacity: store.showCalendar ? 1.0 : 0,
            child: Container(
              height: store.showCalendar ? null : 0,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: ElevationOverlay.colorWithOverlay(
                  colorScheme.surface,
                  colorScheme.onSurface,
                  3.0,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: animationDuration + 80),
                opacity: store.showCalendar ? 1.0 : 0,
                curve: Curves.easeIn,
                child: TableCalendar(
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month'
                  },
                  firstDay: DateTime.utc(DateTime.now().year, 1, 1),
                  lastDay: DateTime.utc(DateTime.now().year + 1, 1, 1),
                  focusedDay: store.dateToShow,
                  selectedDayPredicate: (day) {
                    return isSameDay(store.dateToShow, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    store.showDate(selectedDay);
                    appointments.fetch();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
