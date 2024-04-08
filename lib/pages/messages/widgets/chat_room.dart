import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/messages/widgets/message_appbar.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        userName: "Sidahmed",
        profilePicUrl:
            "https://www.gravatar.com/avatar/b6c4621f5e61cb8fa07c1497b607f334?s=128&d=identicon&r=PG",
        userStatus: "Online",
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: [
                // Chat messages go here
                _buildChatMessage("Hello!", true),
                _buildChatMessage("Hi there!", false),
                _buildChatMessage("How are you?", true),
                _buildChatMessage("I'm good, thanks!", false),
                _buildChatMessage("What about you?", false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: RoundedTextField(
                    controller: TextEditingController(),
                    hintText: 'Type a message...',
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage(String message, bool isSentByCurrentUser) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment:
          isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSentByCurrentUser ? AppTheme.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByCurrentUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
