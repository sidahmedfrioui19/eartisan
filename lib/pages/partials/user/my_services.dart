import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          "Mes services",
          style: AppTheme.headingTextStyle,
        ),
      ]),
    );
  }
}
