import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../utils/theme_data.dart';

class PostToolBar extends StatelessWidget {
  const PostToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              FluentIcons.send_16_regular,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              FluentIcons.bookmark_16_regular,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {})
      ],
    );
  }
}
