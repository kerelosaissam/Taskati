import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';
import 'package:taskati/core/reuseable%20widgets/background_widget.dart';
import 'package:taskati/core/reuseable%20widgets/mainbutton.dart';
import 'package:taskati/feature/home/home.dart';
import 'package:taskati/feature/start/widgets/choosebutton.dart';
import 'package:taskati/feature/start/widgets/textfiels.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final TextEditingController controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? image;

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Complete Your Profile",
                      style: AppTextStyles.titleLarge,
                    ),
                    SizedBox(height: 86),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Profile Image",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Appcolors.btingany,
                        ),
                      ),
                    ),
                    SizedBox(height: 21),
                    Stack(
                      children: [
                        ClipOval(
                          child: image != null
                              ? Image.file(image!, height: 165, width: 165)
                              : Image.asset(
                                  "assets/user.png",
                                  width: 165,
                                  height: 165,
                                ),
                        ),
                        if (image != null)
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Container(
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Appcolors.whitecolor,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Appcolors.redcolor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    image = null;
                                  });
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 34),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Choosebutton(
                          text: 'From Camera',
                          onPressed: () {
                            pickImage(ImageSource.camera);
                          },
                        ),
                        Choosebutton(
                          text: 'From Gallery',
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 45),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Name",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Appcolors.btingany,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Textfield(hintText: "Your name", controller: controller),
                    Spacer(),
                    MainButton(
                      text: 'Let’s Start !',
                      onPressed: () {
                        if (image == null || controller.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Something went wrong. Please enter your name or choose your photo',
                              ),
                              backgroundColor: Appcolors.redcolor,
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                name: controller.text,
                                image: image!,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
