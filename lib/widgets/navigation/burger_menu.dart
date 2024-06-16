import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/pages/authentication/login.dart';
import 'package:profinder/pages/overlays/conditions.dart';
import 'package:profinder/pages/overlays/report.dart';
import 'package:profinder/pages/overlays/suggestion.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/navigation/main_navigation_bar.dart';

class BurgerMenu extends StatelessWidget {
  final AuthenticationService auth = AuthenticationService();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  BurgerMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appThemeData.primaryColor,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      child: FutureBuilder<String?>(
        future: secureStorage.read(key: 'jwtToken'),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView(
                padding: EdgeInsets.only(top: 30),
                children: <Widget>[
                  MenuItem(
                    icon: Icons.message_outlined,
                    text: "Send feedback",
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Report()),
                      );
                    },
                  ),
                  MenuItem(
                    icon: Icons.add,
                    text: "Send a suggestion",
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Suggestion()),
                      );
                    },
                  ),
                  MenuItem(
                    icon: Icons.file_copy_outlined,
                    text: "Terms & usage conditions",
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConditionsOverlay()),
                      );
                    },
                  ),
                  MenuItem(
                    icon: Icons.logout_outlined,
                    text: "Sign out",
                    onPressed: () async {
                      Navigator.pop(context);
                      await AuthenticationService().logout();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainNavBar()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Signed out'), // Confirmation message
                          duration:
                              Duration(seconds: 2), // Adjust duration as needed
                        ),
                      );
                    },
                  ),
                ]);
          } else {
            return ListView(
              padding: EdgeInsets.only(top: 30),
              children: <Widget>[
                MenuItem(
                  icon: Icons.file_copy_outlined,
                  text: "Terms & usage conditions",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConditionsOverlay()),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.login,
                  text: "Sign in",
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          label: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
