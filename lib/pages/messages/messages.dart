import 'package:flutter/material.dart';
import 'package:profinder/pages/messages/chat_room.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/cards/conversation-tile.dart';

import '../../widgets/navigation/burger_menu.dart';
import '../../widgets/appbar/top_bar.dart';

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
        /*RoundedTextField(
          controller: TextEditingController(),
          hintText: "Rechercher",
          icon: FluentIcons.search_12_filled,
        ),*/
        ConversationTile(
          pictureUrl: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
          username: "Frioui Sidahmed",
          onlineStatus: true,
          latestMessage: "message",
          sentTime: "15 MIN",
          unreadCount: 3,
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                  available: true,
                  firstname: "Frioui",
                  lastname: "Sidahmed",
                  pictureUrl:
                      "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                  user_id: "user_id",
                ),
              ),
            )
          },
        ),
      ]),
    );
  }
}
