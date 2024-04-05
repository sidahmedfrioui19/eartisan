import 'package:flutter/material.dart';
import 'package:profinder/models/post/user_post.dart';
import 'package:profinder/services/post.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/progress/loader.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  late Future<List<OwnPostEntity>> _posts;

  final PostService post = PostService();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    _posts = post.fetchUserPosts();
  }

  String statusBuilder(String s) {
    return s == 'active' ? 'En attente' : 'Terminé';
  }

  Color statusColor(String s) {
    return s == 'active' ? AppTheme.secondaryColor : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(5),
        child: FutureBuilder<List<OwnPostEntity>>(
          future: _posts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AppLoading();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final posts = snapshot.data!;
              return Column(
                children: posts.map((post) {
                  return _buildPostCard(post);
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPostCard(OwnPostEntity post) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 0.8, // Reduced shadow
      color: Colors.white, // Used primary color
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    post.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor(post.status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                statusBuilder(post.status),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.check_circle_outline),
                  color: Colors.green,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
