extension DateTimeExtensions on DateTime {
  String get dateOnly => toString().split(" ")[0];

  String get timeOnly => toString().split(" ")[1].substring(0, 5);

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String monthToString() {
    switch (month) {
      case 1:
        {
          return "Janeiro";
        }
      case 2:
        {
          return "Fevereiro";
        }
      case 3:
        {
          return "Março";
        }
      case 4:
        {
          return "Abril";
        }
      case 5:
        {
          return "Maio";
        }
      case 6:
        {
          return "Junho";
        }
      case 7:
        {
          return "Julho";
        }
      case 8:
        {
          return "Agosto";
        }
      case 9:
        {
          return "Setembro";
        }
      case 10:
        {
          return "Outubro";
        }
      case 11:
        {
          return "Novembro";
        }
      case 12:
        {
          return "Dezembro";
        }
      default:
        {
          return "Not valid weekday number";
        }
    }
  }

  String weekdayToString() {
    switch (weekday) {
      case 1:
        {
          return "Segunda";
        }
      case 2:
        {
          return "Terça";
        }
      case 3:
        {
          return "Quarta";
        }
      case 4:
        {
          return "Quinta";
        }
      case 5:
        {
          return "Sexta";
        }
      case 6:
        {
          return "Sábado";
        }
      case 7:
        {
          return "Domingo";
        }
      default:
        {
          return "Not valid weekday number";
        }
    }
  }
}
