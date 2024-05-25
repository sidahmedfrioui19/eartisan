import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/pages/appointments/appointements_page.dart';
import 'package:profinder/pages/home/home.dart';
import 'package:profinder/pages/authentication/login.dart';
import 'package:profinder/pages/messages/messages.dart';
import 'package:profinder/pages/new_action/new_action.dart';
import 'package:profinder/pages/user/user.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/error_handler/connectivity_check.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/action_button.dart';
import 'package:profinder/widgets/cards/no_internet.dart';

class MainNavBar extends StatefulWidget {
  @override
  _MainNavBarState createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  final AuthenticationService auth = AuthenticationService();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? jwtToken = null;

  int _selectedIndex = 0;

  Future<void> _checkConnectivity() async {
    if (await ConnectivityCheck.isConnected()) {
      setState(() {
        _selectedIndex = 0;
      });
    } else {
      setState(() {
        _selectedIndex = -1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  final List<Widget> _pages = [
    HomePage(),
    AppointementsPage(),
    MessagesPage(),
    UserPage()
  ];

  Future<void> getToken() async {
    String? tk = await secureStorage.read(key: 'jwtToken');
    jwtToken = tk;
  }

  @override
  Widget build(BuildContext context) {
    getToken();
    if (_selectedIndex == -1) {
      return InternetError();
    }
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.2),
          ),
        ),
        child: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _onItemTapped(0),
                icon: _selectedIndex == 0
                    ? Icon(FluentIcons.compass_northwest_16_filled,
                        color: AppTheme.primaryColor)
                    : Icon(FluentIcons.compass_northwest_16_regular,
                        color: AppTheme.secondaryColor),
              ),
              IconButton(
                onPressed: () async {
                  await getToken();
                  if (jwtToken != null) {
                    _onItemTapped(1);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                icon: _selectedIndex == 1
                    ? Icon(FluentIcons.calendar_12_filled,
                        color: AppTheme.primaryColor)
                    : Icon(FluentIcons.calendar_12_regular,
                        color: AppTheme.secondaryColor),
              ),
              ActionButton(onPressed: () async {
                await getToken();

                if (jwtToken != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewAction()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
              }),
              IconButton(
                onPressed: () async {
                  await getToken();
                  if (jwtToken != null) {
                    _onItemTapped(2);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                icon: _selectedIndex == 2
                    ? Icon(FluentIcons.chat_12_filled,
                        color: AppTheme.primaryColor)
                    : Icon(FluentIcons.chat_12_regular,
                        color: AppTheme.secondaryColor),
              ),
              IconButton(
                onPressed: () async {
                  await getToken();
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
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
