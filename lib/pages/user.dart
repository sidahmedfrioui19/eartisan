import 'package:flutter/material.dart';

import '../utils/theme_data.dart';
import '../widgets/burger_menu.dart';
import '../widgets/top_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        drawer: BurgerMenu(),
        appBar: TopBar(
          title: "Compte",
        ));
  }
}
