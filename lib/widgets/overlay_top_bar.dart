import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class OverlayTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData dismissIcon;

  const OverlayTopBar(
      {Key? key, required this.title, required this.dismissIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              dismissIcon as IconData?,
              color: appThemeData.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
