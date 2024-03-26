import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/post/post_statusbar.dart';
import 'package:profinder/widgets/post/post_toolbar.dart';
import 'package:profinder/widgets/user_card.dart';

class Post extends StatelessWidget {
  final String title;
  final String description;
  final String username;
  final String job;
  final String pictureUrl;
  final String location;
  final String phoneNumber;
  final bool available;

  const Post({
    Key? key,
    required this.title,
    required this.description,
    required this.username,
    required this.job,
    required this.pictureUrl,
    required this.location,
    required this.phoneNumber,
    required this.available,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius as needed
          boxShadow: [AppTheme.globalShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserCard(
                  pictureUrl: pictureUrl,
                  username: username,
                  content: job,
                  available: available,
                ),
                PostToolBar(
                  icon1: FluentIcons.hand_wave_16_regular,
                  icon2: FluentIcons.bookmark_16_regular,
                )
              ],
            ),
            SizedBox(height: 12),
            Text(title),
            SizedBox(height: 10),
            Text(description),
            PostStatusBar(
              location: location,
              phoneNumber: phoneNumber,
            )
          ],
        ),
      ),
    );
  }
}
