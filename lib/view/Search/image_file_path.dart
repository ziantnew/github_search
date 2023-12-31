import 'dart:io';
import 'package:flutter/material.dart';

class ImageFilePath extends StatelessWidget {
  final String filePath;

  const ImageFilePath({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40, // Adjust the width and height as needed
      child:  Image.file(
        File(filePath),
    ));
  }
}