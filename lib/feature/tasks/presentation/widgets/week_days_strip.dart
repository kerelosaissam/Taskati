import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';
import 'package:taskati/core/utils/date_time_formatters.dart';

class WeekDaysStrip extends StatelessWidget {
  const WeekDaysStrip({
    super.key,
    required this.selectedDate,
    required this.onSelectDate,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectDate;

  @override
  Widget build(BuildContext context) {
    final startDate = selectedDate.subtract(const Duration(days: 2));
    final days = List.generate(5, (index) => startDate.add(Duration(days: index)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) {
        final isSelected = day.day == selectedDate.day &&
            day.month == selectedDate.month &&
            day.year == selectedDate.year;

        return GestureDetector(
          onTap: () => onSelectDate(day),
          child: Container(
            width: 46,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Appcolors.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  DateTimeFormatters.dayNumber(day),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected ? Appcolors.whitecolor : Appcolors.blackcolor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateTimeFormatters.dayShort(day),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isSelected ? Appcolors.whitecolor : Appcolors.btingany,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
