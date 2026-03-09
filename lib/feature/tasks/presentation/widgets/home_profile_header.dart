import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/appstyles.dart';

class HomeProfileHeader extends StatelessWidget {
  const HomeProfileHeader({
    super.key,
    required this.userName,
    required this.imagePath,
  });

  final String userName;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final imageFile = imagePath == null ? null : File(imagePath!);
    final hasImage = imageFile != null && imageFile.existsSync();
    return Row(
      children: [
        CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white,
          child: hasImage
              ? ClipOval(
                  child: Image.file(
                    imageFile,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.person, color: Colors.deepPurple),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello!', style: AppTextStyles.bodySmall),
            const SizedBox(height: 4),
            Text(userName, style: AppTextStyles.bodyLarge),
          ],
        ),
      ],
    );
  }
}
