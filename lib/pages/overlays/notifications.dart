import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/widgets/cards/conversation-tile.dart';

import '../../utils/theme_data.dart';
import '../../widgets/appbar/overlay_top_bar.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
          title: 'Notifications',
          dismissIcon: FluentIcons.chevron_left_12_filled),
      body: ConversationTile(
        pictureUrl: "https://via.placeholder.com/150",
        username: "sidahmed",
        onlineStatus: true,
        latestMessage: "message",
        sentTime: "15 MIN",
        unreadCount: 3,
        onPressed: () => {},
      ),
    );
  }
}
