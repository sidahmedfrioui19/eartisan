import 'package:flutter/material.dart';

// ignore_for_file: deprecated_member_use
class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black;

  // Text Styles
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );
}

final ThemeData appThemeData = ThemeData(
  primaryColor: AppTheme.primaryColor,
  hintColor: AppTheme.secondaryColor,
  scaffoldBackgroundColor: AppTheme.backgroundColor,
  textTheme: const TextTheme(
    headline1: AppTheme.headingTextStyle,
    bodyText1: AppTheme.bodyTextStyle,
  ),
);
