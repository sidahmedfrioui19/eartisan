import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_data.dart';
import '../../widgets/appbar/overlay_top_bar.dart';

class ConditionsOverlay extends StatefulWidget {
  const ConditionsOverlay({super.key});

  @override
  State<ConditionsOverlay> createState() => _ConditionsOverlayState();
}

class _ConditionsOverlayState extends State<ConditionsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
          title: "Conditions d'utilisation",
          dismissIcon: FluentIcons.chevron_left_12_filled),
    );
  }
}
