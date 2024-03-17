import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

import 'stated_avatar.dart';

class UserCard extends StatelessWidget {
  final String pictureUrl;
  final String username;
  final String job;

  const UserCard({
    super.key,
    required this.pictureUrl,
    required this.username,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
            child: StatedAvatar(
          imageUrl: pictureUrl, // Replace with your image URL
          online: true, // Change status to true for online, false for offline
        )),
        SizedBox(width: 13),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: AppTheme.elementTitle,
            ),
            Text(
              job,
              style: AppTheme.smallText,
            )
          ],
        )
      ],
    );
  }
}
