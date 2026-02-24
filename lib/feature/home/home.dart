import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/appstyles.dart';
import 'package:taskati/core/reuseable%20widgets/background_widget.dart';

class HomeScreen extends StatefulWidget {
    final String name;
  final File image;
  const HomeScreen({super.key, required this.name, required this.image});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(),
          SafeArea(child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                    child: Image.file(widget.image, height: 60, width: 60),
                    ),
                    SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello!",style: AppTextStyles.bodyLarge,),
                        SizedBox(height: 4,),
                        Text(widget.name.toUpperCase(),style: AppTextStyles.titleLarge,)
                      ],
                    )
                  ],
                )
              ],
              
            ),
          ))
        ],
      ),
    );
  }
}