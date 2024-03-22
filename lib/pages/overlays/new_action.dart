import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/widgets/layout/overlay_top_bar.dart';

import '../../utils/theme_data.dart';

class NewAction extends StatefulWidget {
  const NewAction({super.key});

  @override
  State<NewAction> createState() => _NewActionState();
}

class _NewActionState extends State<NewAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: OverlayTopBar(
          title: 'Créer',
          dismissIcon: FluentIcons.dismiss_12_filled,
        ));
  }
}
