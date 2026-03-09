import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';
import 'package:taskati/core/utils/date_time_formatters.dart';

class DailyProgressCard extends StatelessWidget {
  const DailyProgressCard({
    super.key,
    required this.progress,
    required this.date,
  });

  final double progress;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final progressPercent = (progress * 100).round();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Appcolors.primaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTimeFormatters.homeHeaderDate(date),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Appcolors.whitecolor.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Your today's task almost done!",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Appcolors.whitecolor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 58,
            height: 58,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: Appcolors.whitecolor.withValues(alpha: 0.25),
                  valueColor: AlwaysStoppedAnimation<Color>(Appcolors.whitecolor),
                ),
                Center(
                  child: Text(
                    '$progressPercent%',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Appcolors.whitecolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
