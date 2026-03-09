import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati/core/constants/hive_boxes.dart';
import 'package:taskati/feature/tasks/data/models/task_model.dart';
import 'package:taskati/feature/tasks/data/models/task_status.dart';

class TaskLocalRepository {
  Box<TaskModel> get _tasksBox => Hive.box<TaskModel>(HiveBoxes.tasks);

  ValueListenable<Box<TaskModel>> listenable() => _tasksBox.listenable();

  List<TaskModel> getAll() {
    final tasks = _tasksBox.values.toList();
    tasks.sort((a, b) => b.date.compareTo(a.date));
    return tasks;
  }

  Future<void> add(TaskModel task) async {
    await _tasksBox.put(task.id.toString(), task);
  }

  Future<void> update(TaskModel task) async {
    await _tasksBox.put(task.id.toString(), task);
  }

  Future<void> markAs(TaskModel task, TaskStatus status) async {
    await _tasksBox.put(task.id.toString(), task.copyWith(status: status));
  }

  Future<void> delete(int taskId) async {
    await _tasksBox.delete(taskId.toString());
  }
}
