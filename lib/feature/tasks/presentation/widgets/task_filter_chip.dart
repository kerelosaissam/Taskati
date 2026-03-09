import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';

class TaskFilterChip extends StatelessWidget {
  const TaskFilterChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Appcolors.primaryColor : Appcolors.lessprimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color: selected ? Appcolors.whitecolor : Appcolors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
