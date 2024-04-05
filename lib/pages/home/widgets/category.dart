import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class Category extends StatelessWidget {
  final String iconUrl;
  final String title;

  const Category({Key? key, required this.title, required this.iconUrl})
      : super(key: key);

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
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryColor,
                ),
                child: ClipOval(
                  child: Image.network(
                    iconUrl,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: AppTheme.categoryText,
          )
        ],
      ),
    );
  }
}
