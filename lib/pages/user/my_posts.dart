import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(children: [
        Text(
          "Mes Clients",
          style: AppTheme.headingTextStyle,
        ),
      ]),
    );
  }
}
