import 'package:flutter/material.dart';
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
          Post(
            title: "Installation spots et vérification électrique",
            description:
                "J'ai besoin d'un électricien quelques vérification et réparation et installation spots (sanitaires et balcon)",
            username: "John Doe",
            job: "Plombier",
            pictureUrl: "https://via.placeholder.com/150",
          )
        ],
      ),
    );
  }
}
