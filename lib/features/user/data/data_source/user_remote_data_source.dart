import 'package:intern_intelligence_social_media_application/core/api/db_api.dart';
import 'package:intern_intelligence_social_media_application/features/user/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<dynamic> createUser(UserModel user);

  Future<UserModel?> getUser(String uId);

  Future<bool> userExists(String uId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DbApi _dbApi;

  UserRemoteDataSourceImpl(this._dbApi);

  @override
  Future<bool> createUser(UserModel user) async {
    return await _dbApi.createUser(user);
  }

  @override
  Future<UserModel?> getUser(String uId) async {
    return await _dbApi.getUser(uId);
  }

  @override
  Future<bool> userExists(String uId) async {
    return await _dbApi.userExists(uId);
  }
}
