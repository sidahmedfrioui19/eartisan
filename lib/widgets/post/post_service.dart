import 'package:flutter/material.dart';
import 'package:profinder/widgets/post/post_toolbar.dart';
import 'package:profinder/widgets/user_card.dart';

class PostService extends StatelessWidget {
  final String title;
  final String description;
  final String username;
  final String job;
  final String pictureUrl;

  const PostService({
    super.key,
    required this.title,
    required this.description,
    required this.username,
    required this.job,
    required this.pictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
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
                  ),
                  PostToolBar()
                ],
              ),
              SizedBox(height: 12),
              Text(title),
              SizedBox(height: 10),
              Text(description)
            ],
          ),
        ));
  }
}
