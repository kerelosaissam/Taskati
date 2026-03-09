import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';
import 'package:taskati/core/reuseable%20widgets/background_widget.dart';
import 'package:taskati/feature/start/data/user_local_repository.dart';
import 'package:taskati/feature/start/start.dart';
import 'package:taskati/feature/tasks/presentation/screens/tasks_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) {
      return;
    }
    final userRepository = UserLocalRepository();
    final nextScreen = userRepository.hasProfile()
        ? const TasksHomeScreen()
        : const Start();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/TaskDone.json'),
                const SizedBox(height: 12),
                Text('Taskati', style: AppTextStyles.large),
                const SizedBox(height: 18),
                Text(
                  'It’s time to get organized',
                  style: AppTextStyles.bodyMedium.copyWith(color: Appcolors.btingany),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
