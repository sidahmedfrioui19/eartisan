import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class MyCustomers extends StatefulWidget {
  const MyCustomers({super.key});

  @override
  State<MyCustomers> createState() => _MyCustomersState();
}

class _MyCustomersState extends State<MyCustomers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(children: [
        Text(
          "Mes Clients",
          style: AppTheme.headingTextStyle,
        ),
      ]),
    );
  }
}
