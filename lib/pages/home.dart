import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/category.dart';
import 'package:profinder/widgets/home_page_selector.dart';
import 'package:profinder/widgets/post_service.dart';
import 'package:profinder/widgets/top_bar.dart';

import '../widgets/burger_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Explorer",
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Catégories",
                      style: AppTheme.elementTitle,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Voir tout",
                        style: TextStyle(
                            color: AppTheme.textColor,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )),
            Row(
              children: [
                Category(
                    title: "Construction", icon: FluentIcons.building_16_filled)
              ],
            ),
            PostService()
          ],
        ),
      ),
    );
  }
}
