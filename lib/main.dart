import 'package:flutter/material.dart';
import 'package:taskati/core/theme.dart';
import 'package:taskati/feature/splashscreen/splashscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(),
      theme: LightTheme.theme,
      debugShowCheckedModeBanner: false,
      );
  }
}
