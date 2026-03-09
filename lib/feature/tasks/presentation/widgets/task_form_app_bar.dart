import 'package:flutter/material.dart';
import 'package:taskati/core/appstyles.dart';

class TaskFormAppBar extends StatelessWidget {
  const TaskFormAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        ),
        Expanded(
          child: Center(
            child: Text(title, style: AppTextStyles.titleLarge),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }
}
