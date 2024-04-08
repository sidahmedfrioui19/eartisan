import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/messages/widgets/message_appbar.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';

class ChatRoom extends StatefulWidget {
  final String user_id;
  final String firstname;
  final String lastname;
  final String pictureUrl;
  final bool available;

  const ChatRoom({
    super.key,
    required this.user_id,
    required this.firstname,
    required this.lastname,
    required this.pictureUrl,
    required this.available,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        userName: '${widget.firstname} ${widget.lastname}',
        profilePicUrl: '${widget.pictureUrl}',
        userStatus: widget.available,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: [],
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Expanded(
                    child: RoundedTextField(
                      controller: TextEditingController(),
                      hintText: 'Message...',
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
