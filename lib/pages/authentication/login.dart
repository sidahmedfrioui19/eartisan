import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profinder/pages/authentication/signup.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/buttons/text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          color: Colors.white,
          buttonsColor: AppTheme.primaryColor,
        ),
        body: Container(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/icon/icon.png',
              height: 130,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Sign in",
              style: AppTheme.headingTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            RoundedTextField(
              controller: _emailController,
              hintText: "Email address",
              icon: FluentIcons.mail_12_filled,
            ),
            RoundedTextField(
              controller: _passwordController,
              hintText: "Password",
              obscured: true,
              icon: FluentIcons.lock_closed_12_filled,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: FilledAppButton(
                      icon: FluentIcons.arrow_right_12_filled,
                      text: "Sign in",
                      onPressed: () async {
                        final String email = _emailController.text;
                        final String password = _passwordController.text;

                        try {
                          await AuthenticationService().login(email, password);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Successfully signed in!'), // Confirmation message
                              duration: Duration(
                                  seconds: 2), // Adjust the duration as needed
                            ),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Your email or password is incorrect'), // Confirmation message
                                duration: Duration(
                                    seconds:
                                        2), // Adjust the duration as needed
                              ),
                            );
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.all(15),
            ),
            Container(
              child: Row(
                children: [
                  Text("Don't have an account yet?"),
                  TextAppButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      text: "Create an account")
                ],
              ),
              margin: EdgeInsets.all(10),
            )
          ]),
          margin: EdgeInsets.all(10),
        ));
  }
}
