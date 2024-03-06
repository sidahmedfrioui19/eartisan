import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets.dart/action_button.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () => {},
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(
            Icons.home_filled,
            color: appThemeData.primaryColor,
          ),
          isSelected: true,
        ),
        IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
        ActionButton(),
        IconButton(onPressed: () => {}, icon: Icon(Icons.message_outlined)),
        IconButton(onPressed: () => {}, icon: Icon(Icons.person_2_outlined))
      ]),
      surfaceTintColor: Colors.white,
    );
  }
}
