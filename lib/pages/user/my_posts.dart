import 'package:flutter/material.dart';
import 'package:profinder/models/post/post_update_request.dart';
import 'package:profinder/models/post/user_post.dart';
import 'package:profinder/services/post/post.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';
import 'package:profinder/widgets/navigation/burger_menu.dart';
import 'package:profinder/widgets/progress/loader.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  late Future<List<OwnPostEntity>> _posts;

  final PostService postService = PostService();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    _posts = postService.fetchUserPosts();
  }

  String statusBuilder(String s) {
    return s == 'active' ? 'Waiting' : 'Completed';
  }

  Color statusColor(String s) {
    return s == 'active' ? AppTheme.secondaryColor : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: OverlayTopBar(
        title: "My requests",
        dismissIcon: Icons.arrow_back,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          child: FutureBuilder<List<OwnPostEntity>>(
            future: _posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppLoading();
              } else if (snapshot.hasError) {
                return Center(
                  child: SnapshotErrorWidget(
                    error: snapshot.error,
                  ),
                );
              } else {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  final posts = snapshot.data!;
                  return Column(
                    children: posts.map((post) {
                      return _buildPostCard(post);
                    }).toList(),
                  );
                } else {
                  return Center(
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 250,
                          ),
                          Icon(
                            Icons.post_add,
                            size: 64,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Requests list empty")
                        ],
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(OwnPostEntity post) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 0.6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 5),
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
                    onPressed: () async {
                      try {
                        await postService.setToComplete(
                            {"_status": "inactive"}, post.postId);
                        setState(() {
                          _loadPosts();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Request marked as complete',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'An error has occured, try again',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.hourglass_top),
                    color: Colors.red,
                    onPressed: () async {
                      try {
                        await postService
                            .setToComplete({"_status": "active"}, post.postId);
                        setState(() {
                          _loadPosts();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Request marked as incomplete',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'An error has occured, try again',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: AppTheme.primaryColor,
                    onPressed: () {
                      _editPost(context, post);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editPost(BuildContext context, OwnPostEntity post) async {
    TextEditingController titleController =
        TextEditingController(text: post.title);
    TextEditingController descriptionController =
        TextEditingController(text: post.description);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Edit request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedTextField(
                controller: titleController,
                hintText: "Title",
              ),
              RoundedTextArea(
                controller: descriptionController,
                hintText: "Description",
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: FilledAppButton(
                    icon: Icons.close,
                    text: "Cancel",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: FilledAppButton(
                    icon: Icons.save,
                    text: "Ok",
                    onPressed: () async {
                      PostUpdateRequest req = PostUpdateRequest(
                        title: titleController.text,
                        description: descriptionController.text,
                      );
                      try {
                        await postService.updatePost(req, post.postId);
                        setState(() {
                          _loadPosts();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Post updated successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('An error occurred, Please try again.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
