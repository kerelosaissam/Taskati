import 'package:flutter/material.dart';
import 'package:taskati/feature/tasks/presentation/models/task_filter.dart';
import 'package:taskati/feature/tasks/presentation/widgets/task_filter_chip.dart';

class TaskFilterTabs extends StatelessWidget {
  const TaskFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final TaskFilter selectedFilter;
  final ValueChanged<TaskFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TaskFilterChip(
          title: 'All',
          selected: selectedFilter == TaskFilter.all,
          onTap: () => onFilterSelected(TaskFilter.all),
        ),
        const SizedBox(width: 8),
        TaskFilterChip(
          title: 'In Progress',
          selected: selectedFilter == TaskFilter.inProgress,
          onTap: () => onFilterSelected(TaskFilter.inProgress),
        ),
        const SizedBox(width: 8),
        TaskFilterChip(
          title: 'Completed',
          selected: selectedFilter == TaskFilter.completed,
          onTap: () => onFilterSelected(TaskFilter.completed),
        ),
      ],
    );
  }
}
