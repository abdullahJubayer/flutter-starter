import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String _defaultFormat = 'dd MMM yyyy';

extension DateTimeExtension on DateTime {
  /// Return a string representing [date] formatted according to our locale
  /// Default format 'dd/MM/yyyy'
  String format([String pattern = _defaultFormat, String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }

  /// Return duration as days
  int getDuration(DateTime? date) {
    if (date == null) return 0;
    Duration duration = difference(date);
    return duration.inDays + 1;
  }

  int? compareDates(DateTime date) {
    date = DateTime(date.year, date.month, date.day);
    final date2 = DateTime(year, month, day);

    if (date2.isAtSameMomentAs(date)) {
      return 0;
    } else if (date2.isBefore(date)) {
      return -1;
    } else if (date2.isAfter(date)) {
      return 1;
    } else {
      return null;
    }
  }

  int? compareDateTime(DateTime date) {
    final date2 = this;

    if (date2.isBefore(date)) {
      return -1;
    } else if (date2.isAfter(date)) {
      return 1;
    } else {
      return null;
    }
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }
}

extension DateTimeExtension2 on int {
  DateTime getDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000);
  }
}
