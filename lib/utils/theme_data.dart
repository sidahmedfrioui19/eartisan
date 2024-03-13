import 'package:flutter/material.dart';

// ignore_for_file: deprecated_member_use
class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF1F1F1F);
  static const Color secondaryColor = Color(0xFF95A5A6);
  static const Color backgroundColor = Color(0xFFF7F7F7);
  static const Color textColor = Color(0xFF1F1F1F);

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
