import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static void showToast({
    required String message,
    ToastGravity gravity = ToastGravity.CENTER,
    int timeInSecForIosWeb = 1,
    Color backgroundColor = const Color(0xff0D5514),
    Color textColor = Colors.white,
    double fontSize = 18.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}