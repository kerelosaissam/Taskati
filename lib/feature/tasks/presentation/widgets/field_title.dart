import 'package:flutter/material.dart';
import 'package:taskati/core/appcolors.dart';
import 'package:taskati/core/appstyles.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.bodySmall.copyWith(color: Appcolors.btingany),
    );
  }
}
