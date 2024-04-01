import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/widgets/filled_button.dart';
import 'package:profinder/widgets/post/post.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20, right: 18, top: 5),
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
          Post(
            title: "Installation spots et vérification électrique",
            description:
                "J'ai besoin d'un électricien quelques vérification et réparation et installation spots (sanitaires et balcon)",
            username: "John Doe",
            job: "Plombier",
            pictureUrl: "https://via.placeholder.com/150",
            location: "Tlemcen, Tlemcen",
            phoneNumber: "0660684077",
            available: true,
          )
        ],
      ),
    );
  }
}
