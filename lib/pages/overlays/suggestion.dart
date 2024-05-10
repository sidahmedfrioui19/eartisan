import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/suggestion/suggestion_creation_request.dart';
import 'package:profinder/services/suggestion/suggestion.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/text_area.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({super.key});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  final TextEditingController _contentController = TextEditingController();
  final SuggestionService _suggestionService = SuggestionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Send a suggestion',
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                RoundedTextArea(
                  controller: _contentController,
                  hintText: "Message",
                  icon: FluentIcons.text_paragraph_16_filled,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: FilledAppButton(
              icon: FluentIcons.send_16_filled,
              text: "Send",
              onPressed: () async {
                SuggestionCreationRequest suggestion =
                    new SuggestionCreationRequest(
                  description: _contentController.text,
                );

                try {
                  await _suggestionService.post(suggestion);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Suggestion envoyé'), // Confirmation message
                      duration:
                          Duration(seconds: 2), // Adjust the duration as needed
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'An error has occured, try again',
                      ), // Confirmation message
                      duration:
                          Duration(seconds: 2), // Adjust the duration as needed
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
