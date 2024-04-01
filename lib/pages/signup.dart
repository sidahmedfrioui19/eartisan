import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profinder/pages/login.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/filled_button.dart';
import 'package:profinder/widgets/layout/overlay_top_bar.dart';
import 'package:profinder/widgets/rounded_text_field.dart';
import 'package:profinder/widgets/text_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Change this to match your app bar color
      statusBarIconBrightness:
          Brightness.light, // Adjust the icon color (light or dark)
    ));
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: OverlayTopBar(
          title: "",
          dismissIcon: FluentIcons.chevron_left_12_filled,
          color: AppTheme.primaryColor,
          buttonsColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Se connecter",
              style: AppTheme.headingTextStyle,
            ),
            SizedBox(
              height: 20,
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
              hintText: "Nom d'utilisateur",
              icon: FluentIcons.number_symbol_16_filled,
            ),
            RoundedTextField(
              controller: TextEditingController(),
              hintText: "Adresse email",
              icon: FluentIcons.mail_12_filled,
            ),
            RoundedTextField(
              controller: TextEditingController(),
              hintText: "Mot de passe",
              obscured: true,
              icon: FluentIcons.lock_closed_12_filled,
            ),
            RoundedTextField(
              controller: TextEditingController(),
              hintText: "Confirmer mot de passe",
              obscured: true,
              icon: FluentIcons.lock_closed_12_filled,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: FilledAppButton(
                        icon: FluentIcons.person_add_16_filled,
                        text: "S'inscrire",
                        onPressed: () => {}),
                  ),
                ],
              ),
              margin: EdgeInsets.all(15),
            ),
            Container(
              child: Row(
                children: [
                  Text("Vous avez déja un compte?"),
                  TextAppButton(
                      onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            )
                          },
                      text: "Se connecter")
                ],
              ),
              margin: EdgeInsets.all(15),
            )
          ]),
          margin: EdgeInsets.all(10),
        )));
  }
}
