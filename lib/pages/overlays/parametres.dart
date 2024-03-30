import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/widgets/filled_button.dart';
import 'package:profinder/widgets/rounded_text_field.dart';

import '../../utils/theme_data.dart';
import '../../widgets/layout/overlay_top_bar.dart';

class SettingsOverlay extends StatefulWidget {
  const SettingsOverlay({super.key});

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  bool _switchState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: OverlayTopBar(
            title: 'Paramétres',
            dismissIcon: FluentIcons.chevron_left_12_filled),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 5, top: 10),
                  child: Text("Détails"),
                ),
                RoundedTextField(
                  controller: TextEditingController(),
                  hintText: "Nom",
                  icon: FluentIcons.person_12_filled,
                ),
                RoundedTextField(
                  controller: TextEditingController(),
                  hintText: "Prénom",
                  icon: FluentIcons.person_12_filled,
                ),
                RoundedTextField(
                  controller: TextEditingController(),
                  hintText: "Adresse email",
                  icon: FluentIcons.mail_12_filled,
                ),
                RoundedTextField(
                  controller: TextEditingController(),
                  hintText: "Localisation",
                  icon: FluentIcons.location_12_filled,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 5, top: 10),
                  child: Text("Contact"),
                ),
                RoundedTextField(
                  controller: TextEditingController(),
                  hintText: "Facebook",
                  icon: Icons.facebook,
                ),
                RoundedTextField(
                  controller: TextEditingController(),
                  hintText: "Instagram",
                  icon: Icons.camera,
                ),
                RoundedTextField(
                  controller: TextEditingController(),
                  hintText: "Tiktok",
                  icon: Icons.tiktok,
                ),
                RoundedTextField(
                  controller: TextEditingController(),
                  hintText: "Phone",
                  icon: FluentIcons.phone_12_filled,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Disponibilité"),
                        Switch(
                          value: _switchState,
                          onChanged: (newValue) {
                            setState(() {
                              _switchState = newValue;
                            });
                          },
                          activeColor: Colors
                              .green, // Customize the active color of the switch
                          inactiveThumbColor: Colors
                              .grey, // Customize the inactive color of the switch
                        ),
                      ]),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: FilledAppButton(
                    icon: FluentIcons.save_16_filled,
                    text: "Enregistrer",
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
