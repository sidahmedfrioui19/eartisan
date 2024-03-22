import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class PostStatusBar extends StatelessWidget {
  final String location;
  final String phoneNumber;
  const PostStatusBar({
    super.key,
    required this.location,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoIcon(icon: FluentIcons.location_12_filled, text: location),
          InfoIcon(icon: FluentIcons.phone_12_filled, text: phoneNumber),
          Icon(
            FluentIcons.hourglass_16_regular,
            color: AppTheme.secondaryColor,
            size: 18,
          )
        ],
      ),
    );
  }
}

class InfoIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoIcon({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.secondaryColor,
          size: 18,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          text,
          style: TextStyle(color: AppTheme.textColor),
        )
      ],
    );
  }
}
