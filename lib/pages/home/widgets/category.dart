import 'package:flutter/material.dart';
import 'package:profinder/pages/home/widgets/category/subcategories_list.dart';
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubcategoryList(),
                  ),
                );
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryColor,
                ),
                child: ClipOval(
                    child: SizedBox(
                  height: 10,
                  width: 10,
                  child: Image.network(
                    iconUrl,
                    fit: BoxFit
                        .contain, // Use BoxFit.contain instead of BoxFit.cover
                    width: 1, // Adjust the width as desired
                    height: 1, // Adjust the height as desired
                  ),
                )),
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
