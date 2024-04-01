import 'package:flutter/material.dart';
import 'package:profinder/pages/partials/home/posts.dart';
import 'package:profinder/pages/partials/home/services.dart';
import 'package:profinder/widgets/layout/home_page_selector.dart';
import 'package:profinder/utils/theme_data.dart';
import '../widgets/layout/burger_menu.dart';
import '../widgets/layout/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Explorer",
      ),
      body: Column(
        children: [
          HomePageSelector(
            servicesSelected: _selectedIndex == 0,
            demandesSelected: _selectedIndex == 1,
            onService: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            onPost: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                ServicesPage(),
                PostsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
