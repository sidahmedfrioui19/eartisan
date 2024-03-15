import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

import '../widgets/burger_menu.dart';
import '../widgets/top_bar.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        drawer: BurgerMenu(),
        appBar: TopBar(
          title: "Messages",
        ));
  }
}
