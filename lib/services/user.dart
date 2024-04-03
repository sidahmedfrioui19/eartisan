import 'dart:convert';
import 'package:profinder/models/user/user.dart';
import 'package:profinder/models/user/user_update_request.dart';
import 'package:profinder/services/data.dart';

class UserService {
  final GenericDataService<UserEntity> _genericService =
      GenericDataService<UserEntity>('user', {
    'get': 'viewall',
    'post': 'create',
    'patch': 'update',
  });

  Future<List<UserEntity>> fetch() async {
    return _genericService.fetch((json) => UserEntity.fromJson(json));
  }

  Future<UserEntity> post(UserEntity entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<UserEntity> patch(UserUpdateEntity update) async {
    final String body = jsonEncode(update.toJson());
    return _genericService.patch(body);
  }
}
