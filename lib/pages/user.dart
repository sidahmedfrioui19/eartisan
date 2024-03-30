import 'package:flutter/material.dart';

import '../utils/theme_data.dart';
import '../widgets/layout/burger_menu.dart';
import '../widgets/layout/top_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final String? imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Compte",
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius:
                            80, // Set radius to 100 to make it 200px in diameter
                        backgroundImage: imageUrl != null &&
                                imageUrl!.isNotEmpty
                            ? NetworkImage(imageUrl!)
                            : NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'John doe',
                        style: AppTheme.headingTextStyle,
                      ),
                      Text('@johndoe')
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
