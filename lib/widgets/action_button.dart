import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {},
      child: Icon(Icons.add),
      shape: CircleBorder(),
      backgroundColor: appThemeData.primaryColor,
      foregroundColor: Colors.white,
    );
  }
}
