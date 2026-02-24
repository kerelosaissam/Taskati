import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';

class Choosebutton extends StatelessWidget {
  final String text;
    final VoidCallback onPressed;
  const Choosebutton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.lessprimary,
          
    
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child:  Center(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(color: Appcolors.primaryColor)
            ),
        ),
        ),
      );
  }
}
