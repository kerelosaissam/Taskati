import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';
import 'package:taskati/core/reuseable%20widgets/background_widget.dart';
import 'package:taskati/feature/start/start.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
void initState() {
  super.initState();
  nav();
}

void nav() async {
  await Future.delayed(Duration(seconds: 6));
  if (!mounted) return;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Start()),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/TaskDone.json'),
              SizedBox(height: 12,),
              Text("Taskati",style: AppTextStyles.large,),
              SizedBox(height: 18,),
              Text("It’s time to get organized",style: AppTextStyles.bodyMedium.copyWith(color: Appcolors.btingany),)
            ],
          )),
        ],
      ),
    );
  }
}
