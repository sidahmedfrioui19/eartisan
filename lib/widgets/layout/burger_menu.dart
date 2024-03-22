import 'package:flutter/material.dart';
import 'package:profinder/pages/overlays/conditions.dart';
import 'package:profinder/pages/overlays/parametres.dart';
import 'package:profinder/pages/overlays/report.dart';
import 'package:profinder/utils/theme_data.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appThemeData.primaryColor,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        padding: EdgeInsets.only(top: 30),
        children: <Widget>[
          MenuItem(
            icon: Icons.settings_outlined,
            text: "Paramétres",
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsOverlay()),
              );
            },
          ),
          MenuItem(
            icon: Icons.message_outlined,
            text: "Envoyer un rapport",
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Report()),
              );
            },
          ),
          MenuItem(
            icon: Icons.file_copy_outlined,
            text: "Conditions d'utilisation",
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConditionsOverlay()),
              );
            },
          ),
          MenuItem(
            icon: Icons.logout_outlined,
            text: "Se déconnecter",
            onPressed: () {},
          ),
        ],
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
