import 'package:hive_ce/hive.dart';

import 'task_status.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.status = TaskStatus.inProgress,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String startTime;

  @HiveField(5)
  final String endTime;

  @HiveField(6)
  final TaskStatus status;

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    String? startTime,
    String? endTime,
    TaskStatus? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }
}
