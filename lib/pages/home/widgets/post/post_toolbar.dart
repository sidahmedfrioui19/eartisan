import 'package:flutter/material.dart';
import 'package:profinder/pages/messages/chat_room.dart';

import '../../../../utils/theme_data.dart';

class PostToolBar extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  final IconData? icon3;
  final String? user_id;
  final String? firstname;
  final String? lastname;
  final String? pictureUrl;
  final bool? available;

  const PostToolBar({
    super.key,
    required this.icon1,
    required this.icon2,
    this.icon3,
    this.user_id,
    this.firstname,
    this.lastname,
    this.pictureUrl,
    this.available,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            icon1,
            color: AppTheme.primaryColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                  available: available!,
                  firstname: firstname!,
                  lastname: lastname!,
                  pictureUrl: pictureUrl!,
                  user_id: user_id!,
                ),
              ),
            );
          },
        ),
        if (icon3 != null)
          IconButton(
            icon: Icon(
              icon3,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {},
          ),
        IconButton(
          icon: Icon(
            icon2,
            color: AppTheme.primaryColor,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
