import 'package:flutter/material.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final String userName;
  final String? profilePicUrl;
  final bool userStatus;

  const CustomAppBar({
    Key? key,
    this.onBack,
    required this.userName,
    required this.profilePicUrl,
    required this.userStatus,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: GestureDetector(
        onTap: () => _showProfileBottomSheet(context),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(profilePicUrl ?? Constants.defaultAvatar),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  userStatus ? 'Available' : 'Not available',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(profilePicUrl ?? Constants.defaultAvatar),
                ),
                SizedBox(height: 16),
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  userStatus ? 'Available' : 'Not available',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                FilledAppButton(
                  icon: Icons.close,
                  text: "Close",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
