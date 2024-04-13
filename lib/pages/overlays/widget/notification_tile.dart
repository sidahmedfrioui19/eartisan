import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String pictureUrl;
  final String username;
  final bool onlineStatus;
  final String latestMessage;
  final VoidCallback? onPressed;

  const NotificationTile({
    super.key,
    required this.pictureUrl,
    required this.username,
    required this.onlineStatus,
    required this.latestMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(pictureUrl),
      ),
      title: Text(username),
      subtitle: Text(latestMessage),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 7,
          ),
          Text(""),
          SizedBox(
            height: 10,
          ),
          Text(""),
        ],
      ),
    );
  }
}
