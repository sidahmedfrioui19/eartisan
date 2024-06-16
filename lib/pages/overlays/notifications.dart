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

  List<NotificationEntity> notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      List<NotificationEntity> fetchedNotifications =
          await notificationService.fetch();
      setState(() {
        notifications = fetchedNotifications;
      });
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Notifications',
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.alert_12_filled,
                    size: 64,
                  ),
                  SizedBox(height: 10),
                  Text("Notifications list empty"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationTile(
                  username: 'Appointment',
                  onlineStatus: true,
                  latestMessage: notifications[index].content ?? '',
                  onPressed: () => {},
                );
              },
            ),
    );
  }
}
