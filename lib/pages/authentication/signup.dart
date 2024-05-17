import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profinder/models/user/user_creation_request.dart';
import 'package:profinder/pages/authentication/login.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/inputs/dropdown.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/buttons/text_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  var _role = 'customer';

  UserCreationRequest buildRequest() {
    return UserCreationRequest(
      username: _usernameController.text,
      firstname: _firstnameController.text,
      lastname: _lastnameController.text,
      role: _role,
      email: _emailController.text,
      password: _passwordController.text,
      address: _addressController.text,
    );
  }

  @override
  void initState() {
    super.initState();

    print(_role);
  }

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/icon/icon.png',
                  height: 130,
                ),
                SizedBox(height: 20),
                Text(
                  "Create Account",
                  style: AppTheme.headingTextStyle,
                ),
                SizedBox(height: 20),
                RoundedDropdownButton<String>(
                  value: _role,
                  onChanged: (String? newValue) {
                    setState(() {
                      _role = newValue!;
                      print(_role);
                    });
                  },
                  hintText: 'Role',
                  items: [
                    DropdownMenuItem(
                      value: 'customer',
                      child: Text('Customer'),
                    ),
                    DropdownMenuItem(
                      value: 'professional',
                      child: Text('Professional'),
                    ),
                  ],
                ),
                RoundedTextField(
                  controller: _lastnameController,
                  hintText: "First name",
                  icon: FluentIcons.person_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please type your first name';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _firstnameController,
                  hintText: "Last name",
                  icon: FluentIcons.person_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please type your last name';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _usernameController,
                  hintText: "Username",
                  icon: FluentIcons.number_symbol_16_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please type your username';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _addressController,
                  hintText: "Address",
                  obscured: false,
                  icon: FluentIcons.location_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please type your adress';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _emailController,
                  hintText: "Email address",
                  icon: FluentIcons.mail_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please type your email address';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscured: true,
                  icon: FluentIcons.lock_closed_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please type your password';
                    }
                    return null;
                  },
                ),
                RoundedTextField(
                  controller:
                      _confirmpasswordController, // Use a separate controller
                  hintText: "Confirm password",
                  obscured: true,
                  icon: FluentIcons.lock_closed_12_filled,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'The password does not match';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledAppButton(
                          icon: FluentIcons.person_add_16_filled,
                          text: "Sign up",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              UserCreationRequest req = buildRequest();
                              try {
                                await AuthenticationService().signup(req);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'User created successfully!',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please verifiy your credentials',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text("Already have an account?"),
                      TextAppButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        text: "Sign in",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
