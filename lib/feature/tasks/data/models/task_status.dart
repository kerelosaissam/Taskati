import 'package:hive_ce/hive.dart';

part 'task_status.g.dart';

@HiveType(typeId: 0)
enum TaskStatus {
  @HiveField(0)
  inProgress,
  @HiveField(1)
  completed,
}
