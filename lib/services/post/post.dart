import 'dart:convert';
import 'package:profinder/models/post/post.dart';
import 'package:profinder/models/post/post_creation_request.dart';
import 'package:profinder/models/post/user_post.dart';
import 'package:profinder/services/data.dart';

class PostService {
  final GenericDataService<PostEntity> _genericService =
      GenericDataService<PostEntity>('post', {
    'get': 'viewall',
    'post': 'add',
  });

  final GenericDataService<OwnPostEntity> _genericServiceUser =
      GenericDataService<OwnPostEntity>('post', {
    'get': 'viewMyPost',
  });

  Future<List<PostEntity>> fetch() async {
    return _genericService.fetch((json) => PostEntity.fromJson(json));
  }

  Future<List<OwnPostEntity>> fetchUserPosts() async {
    return _genericServiceUser.fetch((json) => OwnPostEntity.fromJson(json));
  }

  /*Future<Map<String, bool>> edit(PostUpdateRequest entity) async {
    return _genericServiceUser.patch((json) => PostUpdateRequest.fromJson(json));
  }*/

  Future<Map<String, bool>> post(PostCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
