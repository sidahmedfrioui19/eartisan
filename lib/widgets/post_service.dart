import 'package:flutter/material.dart';

import 'stated_avatar.dart';

class PostService extends StatelessWidget {
  const PostService({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Center(
                      child: StatedAvatar(
                    imageUrl:
                        'https://via.placeholder.com/150', // Replace with your image URL
                    online:
                        true, // Change status to true for online, false for offline
                  )),
                ],
              )
            ],
          ),
        ));
  }
}
