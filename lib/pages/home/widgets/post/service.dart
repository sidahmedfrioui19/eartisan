import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/post/picture.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/home/widgets/post/post_toolbar.dart';
import 'package:profinder/widgets/cards/user_card.dart';

class PostService extends StatelessWidget {
  final String title;
  final String description;
  final String username;
  final String job;
  final String? pictureUrl;
  final bool available;
  final List<Picture>? pictures;

  const PostService({
    Key? key,
    required this.title,
    required this.description,
    required this.username,
    required this.job,
    required this.pictureUrl,
    required this.available,
    this.pictures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
                  icon1: FluentIcons.send_16_regular,
                  icon2: FluentIcons.bookmark_16_regular,
                  icon3: FluentIcons.calendar_12_regular,
                )
              ],
            ),
            SizedBox(height: 12),
            Text(title),
            SizedBox(height: 10),
            Text(description),
            SizedBox(height: 10),
            Text("Realisations"),
            SizedBox(height: 10),
            Wrap(
              spacing: 10, // Adjust spacing as needed
              runSpacing: 10, // Adjust run spacing as needed
              children: pictures != null
                  ? pictures!.take(3).map((picture) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          picture.link,
                          width: 100, // Adjust image width as needed
                          height: 100, // Adjust image height as needed
                          fit: BoxFit.cover, // Adjust image fit as needed
                        ),
                      );
                    }).toList()
                  : [],
            ),
          ],
        ),
      ),
    );
  }
}
