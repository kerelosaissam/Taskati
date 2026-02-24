
import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';


class Textfield extends StatelessWidget {
  final String? text;
  final String? hintText;
  final TextEditingController controller;
  const Textfield({
    super.key,
    this.text,
    this.hintText, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
        SizedBox(height: 6),
        TextField(
          controller:controller ,
          decoration: InputDecoration(
            hintText: hintText,
            
            hintStyle: AppTextStyles.bodyLarge.copyWith(color: Appcolors.blackcolor),
            enabled: true, 
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}