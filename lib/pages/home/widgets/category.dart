import 'package:flutter/material.dart';
import 'package:profinder/models/subcategory/subcategory.dart';
import 'package:profinder/pages/home/widgets/category/subcategories_list.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/theme_data.dart';

class Category extends StatelessWidget {
  final String? iconUrl;
  final String? title;
  final List<SubCategoryEntity> subcategories;
  final String? jwtToken;

  const Category({
    Key? key,
    this.title,
    this.iconUrl,
    required this.subcategories,
    this.jwtToken,
  }) : super(key: key);

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
                    builder: (context) => SubcategoryList(
                      categoryName: title ?? '',
                      subcategories: subcategories,
                      jwtToken: jwtToken,
                    ),
                  ),
                );
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFdcdde1),
                ),
                child: ClipOval(
                    child: SizedBox(
                  height: 10,
                  width: 10,
                  child: (iconUrl != '' && iconUrl != null)
                      ? Image.network(
                          iconUrl ?? Constants.defaultPicture,
                          scale: 10,
                        )
                      : Container(),
                )),
              ),
            ),
          ),
          SizedBox(height: 5),
          if (title != null)
            Text(
              title!,
              style: AppTheme.categoryText,
            )
          else
            Container(
              width: 50,
              height: 10,
              decoration: BoxDecoration(
                color: AppTheme.inputColor,
              ),
            ),
        ],
      ),
    );
  }
}
