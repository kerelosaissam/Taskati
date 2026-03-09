import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati/core/constants/hive_boxes.dart';
import 'package:taskati/feature/tasks/data/models/task_model.dart';
import 'package:taskati/feature/tasks/data/models/task_status.dart';

class HiveInitializer {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskStatusAdapter());
    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>(HiveBoxes.tasks);
    await Hive.openBox<String>(HiveBoxes.userProfile);
  }
}
