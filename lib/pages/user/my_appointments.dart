import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          "Rendez-vous",
          style: AppTheme.headingTextStyle,
        ),
      ]),
    );
  }
}
