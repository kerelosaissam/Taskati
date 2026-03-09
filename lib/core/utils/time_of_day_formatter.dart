import 'package:flutter/material.dart';

class TimeOfDayFormatter {
  static String format(BuildContext context, TimeOfDay time) {
    return MaterialLocalizations.of(context).formatTimeOfDay(
      time,
      alwaysUse24HourFormat: false,
    );
  }
}
