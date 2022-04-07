import 'package:flutter_test/flutter_test.dart';
import 'package:zione/app/modules/core/extensions/datetime_extension.dart';

main() {
  test('should return "2021-01-01"', () {
    final dt = DateTime.parse("2021-01-01 10:01:10");
    expect(dt.dateOnly, "2021-01-01");
  });

  test('should return "10:01"', () {
    final dt = DateTime.parse("2021-01-01 10:01:10");
    expect(dt.timeOnly, "10:01");
  });

  test('should return false on different dates', () {
    final dt = DateTime.parse("2021-01-01 10:01:10");
    final dtDifferent = DateTime.parse("2021-01-02 10:01:10");
    expect(dt.isSameDate(dtDifferent), false);
  });

  test('should return true on same dates', () {
    final dt = DateTime.parse("2021-01-01 10:01:10");
    final dtSame = DateTime.parse("2021-01-01 09:50:20");
    expect(dt.isSameDate(dtSame), true);
  });

  test('should return august on month 8', () {
    final dt = DateTime(2022, 08, 20);
    expect(dt.monthToString().toLowerCase(), "agosto");
  });

  test('should return december on month 12', () {
    final dt = DateTime(2022, 12, 20);
    expect(dt.monthToString().toLowerCase(), "dezembro");
  });

  test('should return sunday', () {
    final dt = DateTime(2022, 05, 08);
    expect(dt.weekdayToString().toLowerCase(), "domingo");
  });

  test('should return december on month 12', () {
    final dt = DateTime(2022, 04, 07);
    expect(dt.weekdayToString().toLowerCase(), "quinta");
  });
}
