import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/post/post.dart';
import 'package:profinder/services/post.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/pages/home/widgets/post/post.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<PostEntity>> _posts;

  final PostService post = PostService();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    _posts = post.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20, right: 18, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledAppButton(
                      icon: FluentIcons.location_12_filled,
                      text: "Mon localisation",
                      onPressed: () => {}),
                  FilledAppButton(
                      icon: FluentIcons.clock_12_filled,
                      text: "Plus récent",
                      onPressed: () => {}),
                ],
              )),
          VerticalList<PostEntity>(
            future: _posts,
            errorMessage: "Aucun service",
            emptyText: "Aucune publiciation",
            itemBuilder: (post) {
              return Post(
                title: post.title,
                description: post.description,
                username: post.username,
                firstname: post.firstname,
                lastname: post.lastname,
                pictureUrl: post.profilePicture,
                location: post.address,
                phoneNumber: post.phoneNumber,
                status: post.status,
              );
            },
          ),
        ],
      ),
    );
  }
}
