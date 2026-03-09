import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati/core/constants/hive_boxes.dart';

class UserLocalRepository {
  Box<String> get _profileBox => Hive.box<String>(HiveBoxes.userProfile);

  bool hasProfile() {
    final name = getName();
    final imagePath = getImagePath();
    return name != null &&
        name.trim().isNotEmpty &&
        imagePath != null &&
        imagePath.trim().isNotEmpty;
  }

  String? getName() => _profileBox.get(HiveProfileKeys.name);

  String? getImagePath() => _profileBox.get(HiveProfileKeys.imagePath);

  Future<void> saveProfile({
    required String name,
    required String imagePath,
  }) async {
    await _profileBox.put(HiveProfileKeys.name, name);
    await _profileBox.put(HiveProfileKeys.imagePath, imagePath);
  }
}
