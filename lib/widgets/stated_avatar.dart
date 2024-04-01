import 'package:flutter/material.dart';

class StatedAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool online;

  const StatedAvatar({super.key, required this.imageUrl, required this.online});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: Image.network(
            imageUrl ??
                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png',
            fit: BoxFit.cover, // Adjust this as needed
          ).image,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: online ? Colors.green : Colors.grey,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
