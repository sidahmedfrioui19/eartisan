import 'package:flutter/material.dart';
import 'package:profinder/pages/new_action/new_post.dart';
import 'package:profinder/pages/new_action/new_service.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../utils/theme_data.dart';

class NewAction extends StatefulWidget {
  const NewAction({Key? key}) : super(key: key);

  @override
  State<NewAction> createState() => _NewActionState();
}

class _NewActionState extends State<NewAction> {
  late List<bool> isSelected;
  int _selected = 0;

  final List<Widget> _partials = [
    NewPost(),
    NewService(),
  ];

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Créer',
        dismissIcon: FluentIcons.dismiss_12_filled,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleButtons(
                    fillColor: AppTheme.primaryColor,
                    selectedColor: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    isSelected: isSelected,
                    onPressed: (int index) {
                      setState(() {
                        isSelected[0] = index == 0;
                        isSelected[1] = index == 1;
                        if (index == 0) {
                          _selected = 0;
                        } else {
                          _selected = 1;
                        }
                      });
                    },
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Demandes"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Service"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _partials[_selected]
            ],
          ),
        ),
      ),
    );
  }
}
