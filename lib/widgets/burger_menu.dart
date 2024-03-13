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
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Paramétres',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Add your home functionality here
                        Navigator.pop(context); // Close the drawer
                      },
                    ))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.message_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Envoyer un rapport',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Add your home functionality here
                        Navigator.pop(context); // Close the drawer
                      },
                    ))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.file_copy_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Conditions d'utilisation",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Add your home functionality here
                        Navigator.pop(context); // Close the drawer
                      },
                    ))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Se déconnecter',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Add your home functionality here
                        Navigator.pop(context); // Close the drawer
                      },
                    ))),
          ],
        ));
  }
}
