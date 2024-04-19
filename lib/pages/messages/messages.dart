import 'package:flutter/material.dart';
import 'package:profinder/models/message/conversation.dart';
import 'package:profinder/pages/messages/chat_room.dart';
import 'package:profinder/services/message/conversation.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/messages/widgets/conversation-tile.dart';
import 'package:profinder/widgets/navigation/burger_menu.dart';
import 'package:profinder/widgets/appbar/top_bar.dart';
import 'package:profinder/widgets/progress/loader.dart'; // Fixed import

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key); // Fixed super keyword

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late Future<List<Conversation>> _conversationFuture;

  final ConversationService conversationService =
      ConversationService(); // Renamed variable

  Future<void> _loadConversations() async {
    _conversationFuture = conversationService.fetch();
  }

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Messages",
      ),
      body: FutureBuilder<List<Conversation>>(
        future: _conversationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoading();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final conversations = snapshot.data ?? [];
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ConversationTile(
                  pictureUrl:
                      conversation.profilePicture ?? Constants.defaultAvatar,
                  username:
                      '${conversation.firstname} ${conversation.lastname}',
                  onlineStatus: true, // You can modify this based on your logic
                  latestMessage: conversation.lastMessage!,
                  sentTime: conversation.lastMessageTimestamp!,
                  unreadCount: 0, // You can modify this based on your logic
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatRoom(
                          available:
                              true, // You can modify this based on your logic
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
