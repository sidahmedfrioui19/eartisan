import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class Category extends StatelessWidget {
  final IconData icon;
  final String title;

  const Category({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, top: 0),
        child: Column(
          children: [
            Center(
                child: InkWell(
              onTap: () {},
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryColor,
                ),
                child: Icon(
                  icon,
                  color: AppTheme.textColor,
                  size: 30,
                ),
              ),
            )),
            SizedBox(height: 5),
            Text(title)
          ],
        ));
  }
}
