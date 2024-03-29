import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/pages/home.dart';
import 'package:profinder/pages/login.dart';
import 'package:profinder/pages/messages.dart';
import 'package:profinder/pages/search.dart';
import 'package:profinder/pages/user.dart';
import 'package:profinder/services/authentication.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/layout/action_button.dart';

class MainNavBar extends StatefulWidget {
  @override
  _MainNavBarState createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  final AuthenticationService auth = AuthenticationService();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    MessagesPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _onItemTapped(0),
                icon: _selectedIndex == 0
                    ? Icon(FluentIcons.home_12_filled,
                        color: AppTheme.primaryColor)
                    : Icon(FluentIcons.home_12_regular,
                        color: AppTheme.secondaryColor),
              ),
              IconButton(
                onPressed: () => _onItemTapped(1),
                icon: _selectedIndex == 1
                    ? Icon(FluentIcons.search_12_filled,
                        color: AppTheme.primaryColor)
                    : Icon(FluentIcons.search_12_regular,
                        color: AppTheme.secondaryColor),
              ),
              ActionButton(),
              IconButton(
                onPressed: () => _onItemTapped(2),
                icon: _selectedIndex == 2
                    ? Icon(FluentIcons.chat_12_filled,
                        color: AppTheme.primaryColor)
                    : Icon(FluentIcons.chat_12_regular,
                        color: AppTheme.secondaryColor),
              ),
              IconButton(
                onPressed: () async {
                  final String? jwtToken =
                      await secureStorage.read(key: 'jwtToken');
                  if (jwtToken != null) {
                    _onItemTapped(3);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                icon: _selectedIndex == 3
                    ? Icon(FluentIcons.person_12_filled,
                        color: AppTheme.primaryColor)
                    : Icon(FluentIcons.person_12_regular,
                        color: AppTheme.secondaryColor),
              ),
            ],
          ),
          surfaceTintColor: Colors.white,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
