import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';
import 'package:taskati/core/reuseable%20widgets/background_widget.dart';
import 'package:taskati/core/utils/date_time_formatters.dart';
import 'package:taskati/feature/start/data/user_local_repository.dart';
import 'package:taskati/feature/tasks/data/models/task_model.dart';
import 'package:taskati/feature/tasks/data/models/task_status.dart';
import 'package:taskati/feature/tasks/data/task_local_repository.dart';
import 'package:taskati/feature/tasks/presentation/models/task_filter.dart';
import 'package:taskati/feature/tasks/presentation/screens/add_task_screen.dart';
import 'package:taskati/feature/tasks/presentation/screens/edit_task_screen.dart';
import 'package:taskati/feature/tasks/presentation/widgets/daily_progress_card.dart';
import 'package:taskati/feature/tasks/presentation/widgets/home_profile_header.dart';
import 'package:taskati/feature/tasks/presentation/widgets/task_card.dart';
import 'package:taskati/feature/tasks/presentation/widgets/task_filter_tabs.dart';
import 'package:taskati/feature/tasks/presentation/widgets/week_days_strip.dart';

class TasksHomeScreen extends StatefulWidget {
  const TasksHomeScreen({super.key});

  @override
  State<TasksHomeScreen> createState() => _TasksHomeScreenState();
}

class _TasksHomeScreenState extends State<TasksHomeScreen> {
  final TaskLocalRepository _taskRepository = TaskLocalRepository();
  final UserLocalRepository _userRepository = UserLocalRepository();
  TaskFilter _selectedFilter = TaskFilter.all;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedDate = await Navigator.push<DateTime>(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
          if (selectedDate != null && mounted) {
            setState(() {
              _selectedDate = selectedDate;
              _selectedFilter = TaskFilter.all;
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: ValueListenableBuilder<Box<TaskModel>>(
                valueListenable: _taskRepository.listenable(),
                builder: (context, box, child) {
                  final tasks = _filteredTasks();
                  final progress = _selectedDateProgress();
                  final userName = _userRepository.getName() ?? 'User';
                  final imagePath = _userRepository.getImagePath();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeProfileHeader(userName: userName, imagePath: imagePath),
                      const SizedBox(height: 18),
                      DailyProgressCard(progress: progress, date: _selectedDate),
                      const SizedBox(height: 14),
                      Text(
                        DateTimeFormatters.monthName(_selectedDate),
                        style: AppTextStyles.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      WeekDaysStrip(
                        selectedDate: _selectedDate,
                        onSelectDate: (date) => setState(() => _selectedDate = date),
                      ),
                      const SizedBox(height: 14),
                      TaskFilterTabs(
                        selectedFilter: _selectedFilter,
                        onFilterSelected: (filter) => setState(() => _selectedFilter = filter),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: tasks.isEmpty
                            ? const Center(child: Text('No tasks for this filter'))
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  final task = tasks[index];
                                  return Dismissible(
                                    key: ValueKey(task.id),
                                    background: _deleteSwipeBackground(),
                                    secondaryBackground: _actionSwipeBackground(),
                                    confirmDismiss: (direction) async {
                                      if (direction == DismissDirection.startToEnd) {
                                        return _confirmDelete(task);
                                      }
                                      if (direction == DismissDirection.endToStart) {
                                        await _showLeftSwipeActions(task);
                                      }
                                      return false;
                                    },
                                    onDismissed: (_) => _taskRepository.delete(task.id),
                                    child: TaskCard(
                                      task: task,
                                      onTap: () async {
                                        final selectedDate = await Navigator.push<DateTime>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EditTaskScreen(task: task),
                                          ),
                                        );
                                        if (selectedDate != null && mounted) {
                                          setState(() {
                                            _selectedDate = selectedDate;
                                            _selectedFilter = TaskFilter.all;
                                          });
                                        }
                                      },
                                      onMarkDone: () =>
                                          _taskRepository.markAs(task, TaskStatus.completed),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => const SizedBox(height: 10),
                                itemCount: tasks.length,
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TaskModel> _filteredTasks() {
    final allTasks = _taskRepository.getAll();
    final selectedDateTasks = allTasks.where((task) {
      return task.date.year == _selectedDate.year &&
          task.date.month == _selectedDate.month &&
          task.date.day == _selectedDate.day;
    }).toList();

    if (_selectedFilter == TaskFilter.all) {
      // If selected day has no tasks, still show existing tasks
      // so the user never lands on an empty screen unexpectedly.
      return selectedDateTasks.isNotEmpty ? selectedDateTasks : allTasks;
    }

    if (_selectedFilter == TaskFilter.completed) {
      return selectedDateTasks
          .where((task) => task.status == TaskStatus.completed)
          .toList();
    }

    return selectedDateTasks
        .where((task) => task.status == TaskStatus.inProgress)
        .toList();
  }

  double _selectedDateProgress() {
    final selectedDateTasks = _taskRepository.getAll().where((task) {
      return task.date.year == _selectedDate.year &&
          task.date.month == _selectedDate.month &&
          task.date.day == _selectedDate.day;
    }).toList();
    if (selectedDateTasks.isEmpty) {
      return 0;
    }
    final completedCount =
        selectedDateTasks.where((task) => task.status == TaskStatus.completed).length;
    return completedCount / selectedDateTasks.length;
  }

  Future<bool> _confirmDelete(TaskModel task) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: Text('Delete "${task.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
    return shouldDelete ?? false;
  }

  Future<void> _showLeftSwipeActions(TaskModel task) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: Color(0xFFF9A825)),
                title: const Text('Edit Task'),
                onTap: () async {
                  Navigator.pop(context);
                  final selectedDate = await Navigator.push<DateTime>(
                    this.context,
                    MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
                  );
                  if (selectedDate != null && mounted) {
                    setState(() {
                      _selectedDate = selectedDate;
                      _selectedFilter = TaskFilter.all;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_circle_outline, color: Color(0xFF2E7D32)),
                title: const Text('Mark as Done'),
                onTap: () async {
                  Navigator.pop(context);
                  await _taskRepository.markAs(task, TaskStatus.completed);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _deleteSwipeBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.redcolor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.82),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_outline, color: Appcolors.redcolor, size: 18),
            const SizedBox(width: 6),
            Text(
              'Delete',
              style: AppTextStyles.bodySmall.copyWith(color: Appcolors.redcolor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionSwipeBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.lessprimary.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _actionTag(
            label: 'Done',
            icon: Icons.check_circle_outline,
            textColor: const Color(0xFF2E7D32),
            background: const Color(0xFFE8F5E9),
          ),
          const SizedBox(width: 8),
          _actionTag(
            label: 'Edit',
            icon: Icons.edit_outlined,
            textColor: const Color(0xFFF9A825),
            background: const Color(0xFFFFF8E1),
          ),
        ],
      ),
    );
  }

  Widget _actionTag({
    required String label,
    required IconData icon,
    required Color textColor,
    required Color background,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 16),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
