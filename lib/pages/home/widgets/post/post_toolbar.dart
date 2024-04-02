import 'package:flutter/material.dart';

import '../../../../utils/theme_data.dart';

class PostToolBar extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  const PostToolBar({
    super.key,
    required this.icon1,
    required this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              icon1,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              icon2,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {})
      ],
    );
  }
}
