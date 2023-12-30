import 'dart:io';
import 'package:flutter/material.dart';

class ImageFilePath extends StatelessWidget {
  final String filePath;

  const ImageFilePath({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(filePath),
      width: 100, // Adjust the width as needed
      height: 100, // Adjust the height as needed
      fit: BoxFit.cover, // Adjust the BoxFit as needed
    );
  }
}