import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profinder/models/user.dart';
import 'package:profinder/models/user_update_request.dart';
import 'package:profinder/pages/user/my_appointments.dart';
import 'package:profinder/pages/user/my_posts.dart';
import 'package:profinder/pages/user/my_services.dart';
import 'package:profinder/services/authentication.dart';
import 'package:profinder/services/user.dart';
import 'package:profinder/utils/helpers.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/cards/verification_badge.dart';
import 'package:profinder/widgets/navigation/burger_menu.dart';
import 'package:profinder/widgets/appbar/top_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late Future<UserEntity> _userFuture;
  late TabController _tabController = TabController(length: 2, vsync: this);

  final AuthenticationService auth = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the tab controller
    super.dispose();
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

  void _changeProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);

      Reference storageReference = FirebaseStorage.instance.ref().child(
          'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Changement d'image..."),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );

      TaskSnapshot snapshot = await uploadTask;

      String downloadURL = await snapshot.ref.getDownloadURL();

      try {
        UserUpdateEntity updatedData =
            UserUpdateEntity(profilePicture: downloadURL);
        await UserService().patch(updatedData);

        print('Profile picture URL updated: $downloadURL');
      } catch (error) {
        print('Error updating profile picture: $error');
      }

      Navigator.of(context).pop();

      print('Uploaded image download URL: $downloadURL');
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
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: Image.network(
                          user.profilePic ??
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png',
                          fit: BoxFit.cover, // Adjust this as needed
                        ).image,
                      ),
                      GestureDetector(
                        onTap: () {
                          _changeProfilePicture();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  SizedBox(height: 10),
                  Text('@${user.username}'),
                  SizedBox(height: 20),
                  TabBar(
                    indicatorColor: AppTheme.primaryColor,
                    labelColor: AppTheme.primaryColor,
                    unselectedLabelColor: Colors.black,
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Mes Clients'),
                      Tab(text: 'Mes Services'),
                      Tab(text: 'Rendez-vous'),
                    ],
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: 16), // Adjust padding as needed
                    labelStyle: TextStyle(
                        fontSize: 12), // Adjust the font size as needed
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        MyPosts(),
                        MyServices(),
                        MyAppointments(),
                      ],
                    ),
                  ),
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
