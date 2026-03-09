import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';
import 'package:taskati/feature/tasks/data/models/task_model.dart';
import 'package:taskati/feature/tasks/data/models/task_status.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onMarkDone,
  });

  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onMarkDone;

  @override
  Widget build(BuildContext context) {
    final isDone = task.status == TaskStatus.completed;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Appcolors.whitecolor.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: AppTextStyles.bodyLarge),
            const SizedBox(height: 6),
            Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall.copyWith(color: Appcolors.btingany),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.watch_later_outlined, color: Appcolors.primaryColor, size: 16),
                const SizedBox(width: 5),
                Text(
                  '${task.startTime} - ${task.endTime}',
                  style: AppTextStyles.bodySmall.copyWith(color: Appcolors.primaryColor),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: isDone ? null : onMarkDone,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDone ? Appcolors.lessprimary : Appcolors.lessorange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isDone ? 'Done' : 'In Progress',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDone ? Appcolors.primaryColor : Appcolors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
