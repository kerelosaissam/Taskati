import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';

class MainButton extends StatelessWidget {
  final String text;
    final VoidCallback onPressed;
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.primaryColor,
          
    
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child:  Center(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(color: Appcolors.whitecolor)
            ),
        ),
        ),
      );
  }
}
