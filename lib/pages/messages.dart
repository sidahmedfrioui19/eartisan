import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/messages/conversation-tile.dart';
import 'package:profinder/widgets/rounded_text_field.dart';

import '../widgets/layout/burger_menu.dart';
import '../widgets/layout/top_bar.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Messages",
      ),
      body: Column(children: [
        RoundedTextField(
          controller: TextEditingController(),
          hintText: "Rechercher",
        ),
        ConversationTile(
          pictureUrl: "https://via.placeholder.com/150",
          username: "sidahmed",
          onlineStatus: true,
          latestMessage: "message",
          sentTime: "15 MIN",
          unreadCount: 3,
          onPressed: () => {},
        ),
        ConversationTile(
          pictureUrl: "https://via.placeholder.com/150",
          username: "sidahmed",
          onlineStatus: true,
          latestMessage: "message",
          sentTime: "15 MIN",
          unreadCount: 3,
          onPressed: () => {},
        ),
      ]),
    );
  }
}
