import 'package:flutter/material.dart';
import 'package:taskati/core/storage/hive_initializer.dart';
import 'package:taskati/core/theme.dart';
import 'package:taskati/feature/splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitializer.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const SplashScreen(),
      theme: LightTheme.theme,
      debugShowCheckedModeBanner: false,
      );
  }
}
