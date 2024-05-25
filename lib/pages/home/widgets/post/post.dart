import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/home/widgets/post/post_statusbar.dart';
import 'package:profinder/pages/home/widgets/post/post_toolbar.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/cards/user_card.dart';

class Post extends StatelessWidget {
  final String? title;
  final String? description;
  final String username;
  final String firstname;
  final String lastname;
  final String? userId;
  final String? userRole;
  final String? pictureUrl;
  final String? location;
  final String? phoneNumber;
  final String? status;
  final bool? available;
  final String? currentUserId;
  final String? jwtToken;

  const Post({
    Key? key,
    required this.title,
    required this.description,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.pictureUrl,
    required this.location,
    required this.phoneNumber,
    required this.status,
    this.userId,
    this.userRole,
    this.currentUserId,
    this.available,
    this.jwtToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [AppTheme.globalShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _showProfileBottomSheet(context),
                  child: UserCard(
                    pictureUrl: pictureUrl ?? Constants.defaultAvatar,
                    username: '$firstname $lastname',
                    content: '@${username}',
                  ),
                ),
                if (this.currentUserId != userId &&
                    jwtToken != null &&
                    this.userRole != 'customer')
                  PostToolBar(
                    icon1: FluentIcons.mail_16_regular,
                    pictureUrl: pictureUrl,
                    firstname: firstname,
                    lastname: lastname,
                    user_id: userId,
                    available: available,
                  )
              ],
            ),
            SizedBox(height: 12),
            Text(title!),
            SizedBox(height: 10),
            Text(description!),
            PostStatusBar(
              location: location,
              phoneNumber: phoneNumber,
              status: status,
            )
          ],
        ),
      ),
    );
  }

  void _showProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(pictureUrl ?? Constants.defaultAvatar),
                ),
                SizedBox(height: 16),
                Text(
                  '$firstname $lastname',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '@$username',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  location ?? 'No location provided',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  phoneNumber ?? 'No phone number provided',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  available == true ? 'Available' : 'Not available',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                FilledAppButton(
                  icon: Icons.close,
                  text: "Close",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
