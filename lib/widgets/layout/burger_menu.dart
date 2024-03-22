import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: appThemeData.primaryColor,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
          padding: EdgeInsets.only(top: 30),
          children: <Widget>[
            MenuItem(icon: Icons.settings_outlined, text: "Paramétres"),
            MenuItem(icon: Icons.message_outlined, text: "Envoyer un rapport"),
            MenuItem(
                icon: Icons.file_copy_outlined,
                text: "Conditions d'utilisation"),
            MenuItem(icon: Icons.logout_outlined, text: "Se déconnecter"),
          ],
        ));
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const MenuItem({super.key, required this.icon, required this.text});

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
              onPressed: () {
                // Add your home functionality here
                Navigator.pop(context); // Close the drawer
              },
            )));
  }
}
