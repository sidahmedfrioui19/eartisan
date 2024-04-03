import 'package:flutter/material.dart';
import 'package:profinder/models/post/user_post.dart';
import 'package:profinder/services/post.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<OwnPostEntity>>(
              future: _posts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final posts = snapshot.data!;
                  return SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Title')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: posts.map((post) {
                        return DataRow(cells: [
                          DataCell(Text(post.title)),
                          DataCell(Text(post.description)),
                          DataCell(Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check),
                                onPressed: () {
                                  // Implement edit functionality here
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Implement delete functionality here
                                },
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
