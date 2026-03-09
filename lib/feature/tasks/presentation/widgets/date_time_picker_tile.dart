import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';

class DateTimePickerTile extends StatelessWidget {
  const DateTimePickerTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: Appcolors.primaryColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.bodySmall.copyWith(color: Appcolors.btingany)),
                  const SizedBox(height: 2),
                  Text(value, style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 24),
          ],
        ),
      ),
    );
  }
}
