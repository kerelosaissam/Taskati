import 'package:intl/intl.dart';

class DateTimeFormatters {
  static String taskDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }

  static String homeHeaderDate(DateTime date) {
    return DateFormat('EEE, dd MMM').format(date);
  }

  static String monthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  static String dayNumber(DateTime date) {
    return DateFormat('dd').format(date);
  }

  static String dayShort(DateTime date) {
    return DateFormat('EEE').format(date);
  }
}
