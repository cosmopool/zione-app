import 'package:flutter/material.dart';

class DateFlag extends StatelessWidget {
  final String dateString;

  const DateFlag({Key? key, required this.dateString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(dateString);
    final day = date.day.toString();
    late final String weekday;

    switch (date.weekday) {
      case 1:
        {
          weekday = "segunda";
        }
        break;
      case 2:
        {
          weekday = "terca";
        }
        break;
      case 3:
        {
          weekday = "quarta";
        }
        break;
      case 4:
        {
          weekday = "quinta";
        }
        break;
      case 5:
        {
          weekday = "sexta";
        }
        break;
      case 6:
        {
          weekday = "sabado";
        }
        break;
      case 7:
        {
          weekday = "domingo";
        }
        break;
    }

    return Container(
      // height: 50.0,
      color: Theme.of(context).primaryColor,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              weekday,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            day,
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
    );
  }
}
