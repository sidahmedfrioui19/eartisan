import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/filled_button.dart';
import 'package:profinder/widgets/rounded_text_field.dart';
import 'package:profinder/widgets/text_area.dart';

class NewService extends StatefulWidget {
  const NewService({super.key});

  @override
  State<NewService> createState() => _NewServiceState();
}

class _NewServiceState extends State<NewService> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Créer un service",
                  style: AppTheme.headingTextStyle,
                )
              ],
            ),
          ),
          RoundedTextField(
            controller: TextEditingController(),
            hintText: "Nom",
            icon: FluentIcons.text_header_1_lines_16_filled,
          ),
          RoundedTextArea(
            controller: TextEditingController(),
            hintText: "Description",
            icon: FluentIcons.text_paragraph_16_filled,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: FilledAppButton(
              icon: FluentIcons.add_12_filled,
              text: "Publier",
              onPressed: () async {},
            ),
          ),
        ],
      ),
    );
  }
}
