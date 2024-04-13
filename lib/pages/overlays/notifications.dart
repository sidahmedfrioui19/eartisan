import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:profinder/models/notification/notification.dart';
import 'package:profinder/pages/overlays/widget/notification_tile.dart';
import 'package:profinder/services/notification/notification.dart';

import '../../utils/theme_data.dart';
import '../../widgets/appbar/overlay_top_bar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationService notificationService = NotificationService();

  List<NotificationEntity> notifications = []; // List to hold notifications

  @override
  void initState() {
    super.initState();
    _fetchNotifications(); // Fetch notifications when the widget is initialized
  }

  Future<void> _fetchNotifications() async {
    try {
      List<NotificationEntity> fetchedNotifications =
          await notificationService.fetch(); // Fetch notifications
      setState(() {
        notifications = fetchedNotifications; // Update notifications list
      });
    } catch (error) {
      print('Error fetching notifications: $error');
      // Handle error appropriately (e.g., show error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Notifications',
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationTile(
            pictureUrl:
                "https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Minimalist_info_Icon.png/768px-Minimalist_info_Icon.png", // Access user profile picture URL
            username:
                notifications[index].user.username ?? "", // Access username
            onlineStatus:
                true, // You can set online status as per your requirement
            latestMessage: notifications[index].content ??
                "", // Access notification content
            onPressed: () =>
                {}, // onPressed callback (you can add functionality here)
          );
        },
      ),
    );
  }
}
