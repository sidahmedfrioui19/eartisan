import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/providers/conversations_provider.dart';
import 'package:provider/provider.dart';
import 'package:profinder/pages/messages/chat_room.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/messages/widgets/conversation-tile.dart';
import 'package:profinder/widgets/navigation/burger_menu.dart';
import 'package:profinder/widgets/appbar/top_bar.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
    // Fetch conversations when the page initializes
    Provider.of<ConversationProvider>(context, listen: false)
        .fetchConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Messages",
      ),
      body: Consumer<ConversationProvider>(
        builder: (context, provider, _) {
          final conversations = provider.conversations;
          if (conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.mail_20_filled,
                    size: 48,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("No conversations"),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ConversationTile(
                  pictureUrl:
                      conversation.profilePicture ?? Constants.defaultAvatar,
                  username:
                      '${conversation.firstname} ${conversation.lastname}',
                  onlineStatus: true,
                  latestMessage: conversation.lastMessage!,
                  sentTime: conversation.lastMessageTimestamp!,
                  unreadCount: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatRoom(
                          available: true,
                          firstname: conversation.firstname!,
                          lastname: conversation.lastname!,
                          pictureUrl: conversation.profilePicture ??
                              Constants.defaultAvatar,
                          user_id: conversation.userId!,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
