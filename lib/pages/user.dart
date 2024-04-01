import 'package:flutter/material.dart';
import 'package:profinder/models/user.dart';
import 'package:profinder/services/authentication.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/verification_badge.dart';
import 'package:profinder/widgets/layout/burger_menu.dart';
import 'package:profinder/widgets/layout/top_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<UserEntity> _userFuture;

  final AuthenticationService auth = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser(); // Initialize _userFuture here
  }

  Future<UserEntity> _loadUser() async {
    try {
      final UserEntity user = await auth.fetchUserData();
      return user;
    } catch (error) {
      // Handle the error here
      print('Error loading user data: $error');
      throw error; // Rethrow the error to propagate it to the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Compte",
      ),
      body: FutureBuilder<UserEntity>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final UserEntity user = snapshot.data!;
            return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(user.profilePic ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${user.firstname} ${user.lastname}',
                        style: AppTheme.headingTextStyle,
                      ),
                      SizedBox(width: 5),
                      VerificationBadge(
                        isVerified: Helpers.boolVal(
                          user.verified,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('@${user.username}'),
                ],
              ),
            );
          } else {
            return Center(child: Text('No user data available.'));
          }
        },
      ),
    );
  }
}
