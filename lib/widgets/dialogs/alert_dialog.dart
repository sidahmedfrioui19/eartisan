import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String title;
  final String content;
  const Alert({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Do you want to proceed?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Close the dialog and return false
          },
          child: Text('Non'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Close the dialog and return true
          },
          child: Text('Oui'),
        ),
      ],
    );
  }
}
