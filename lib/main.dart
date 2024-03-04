import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Job Finder', theme: appThemeData, home: Scaffold());
  }
}
