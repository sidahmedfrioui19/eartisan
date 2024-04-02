import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
                  "Créer une demande",
                  style: AppTheme.headingTextStyle,
                )
              ],
            ),
          ),
          RoundedTextField(
            controller: _titleController,
            hintText: "Titre",
            icon: FluentIcons.text_header_1_lines_16_filled,
          ),
          RoundedTextArea(
            controller: _descriptionController,
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
