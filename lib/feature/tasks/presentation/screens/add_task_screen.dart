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

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskLocalRepository _taskRepository = TaskLocalRepository();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _date = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 8, minute: 0);

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
                  const TaskFormAppBar(title: 'Add Task'),
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
                    text: 'Add Task',
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
    final task = TaskModel(
      id: DateTime.now().microsecondsSinceEpoch,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      date: _date,
      startTime: TimeOfDayFormatter.format(context, _startTime),
      endTime: TimeOfDayFormatter.format(context, _endTime),
    );
    await _taskRepository.add(task);
    if (!mounted) {
      return;
    }
    Navigator.pop(context, _date);
  }
}
