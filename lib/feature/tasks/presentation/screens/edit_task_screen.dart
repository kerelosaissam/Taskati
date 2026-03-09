import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/reuseable%20widgets/background_widget.dart';
import 'package:taskati/core/reuseable%20widgets/mainbutton.dart';
import 'package:taskati/core/utils/date_time_formatters.dart';
import 'package:taskati/core/utils/time_of_day_formatter.dart';
import 'package:taskati/feature/tasks/data/models/task_model.dart';
import 'package:taskati/feature/tasks/data/task_local_repository.dart';
import 'package:taskati/feature/tasks/presentation/widgets/date_time_picker_tile.dart';
import 'package:taskati/feature/tasks/presentation/widgets/field_title.dart';
import 'package:taskati/feature/tasks/presentation/widgets/task_form_app_bar.dart';
import 'package:taskati/feature/tasks/presentation/widgets/task_input_field.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TaskLocalRepository _taskRepository = TaskLocalRepository();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  late DateTime _date;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _date = widget.task.date;
    _startTime = _parseTime(widget.task.startTime);
    _endTime = _parseTime(widget.task.endTime);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TaskFormAppBar(title: 'Edit Task'),
                  const SizedBox(height: 24),
                  const FieldTitle(text: 'Title'),
                  const SizedBox(height: 8),
                  TaskInputField(controller: _titleController, hintText: 'Task title'),
                  const SizedBox(height: 16),
                  const FieldTitle(text: 'Description'),
                  const SizedBox(height: 8),
                  TaskInputField(
                    controller: _descriptionController,
                    hintText: 'Task description',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  DateTimePickerTile(
                    icon: Icons.calendar_month_outlined,
                    label: 'Date',
                    value: DateTimeFormatters.taskDate(_date),
                    onTap: _pickDate,
                  ),
                  const SizedBox(height: 12),
                  DateTimePickerTile(
                    icon: Icons.watch_later_outlined,
                    label: 'Start Time',
                    value: TimeOfDayFormatter.format(context, _startTime),
                    onTap: _pickStartTime,
                  ),
                  const SizedBox(height: 12),
                  DateTimePickerTile(
                    icon: Icons.watch_later_outlined,
                    label: 'End Time',
                    value: TimeOfDayFormatter.format(context, _endTime),
                    onTap: _pickEndTime,
                  ),
                  const Spacer(),
                  MainButton(
                    text: 'Save',
                    onPressed: _saveTask,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() => _date = selectedDate);
    }
  }

  Future<void> _pickStartTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (selectedTime != null) {
      setState(() => _startTime = selectedTime);
    }
  }

  Future<void> _pickEndTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (selectedTime != null) {
      setState(() => _endTime = selectedTime);
    }
  }

  Future<void> _saveTask() async {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all fields'),
          backgroundColor: Appcolors.redcolor,
        ),
      );
      return;
    }
    final updatedTask = widget.task.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      date: _date,
      startTime: TimeOfDayFormatter.format(context, _startTime),
      endTime: TimeOfDayFormatter.format(context, _endTime),
    );
    await _taskRepository.update(updatedTask);
    if (!mounted) {
      return;
    }
    Navigator.pop(context, _date);
  }

  TimeOfDay _parseTime(String value) {
    final now = TimeOfDay.now();
    try {
      final parsed = TimeOfDay(
        hour: DateTime.parse('2026-01-01 ${_to24Hour(value)}').hour,
        minute: DateTime.parse('2026-01-01 ${_to24Hour(value)}').minute,
      );
      return parsed;
    } catch (_) {
      return now;
    }
  }

  String _to24Hour(String value) {
    final lower = value.toLowerCase();
    final isPm = lower.contains('pm');
    final cleaned = lower.replaceAll('am', '').replaceAll('pm', '').trim();
    final parts = cleaned.split(':');
    int hour = int.tryParse(parts.first) ?? 0;
    final int minute = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;
    if (isPm && hour < 12) {
      hour += 12;
    }
    if (!isPm && hour == 12 && lower.contains('am')) {
      hour = 0;
    }
    final hh = hour.toString().padLeft(2, '0');
    final mm = minute.toString().padLeft(2, '0');
    return '$hh:$mm:00';
  }
}
