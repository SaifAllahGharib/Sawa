import '../model/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<dynamic> createUser(UserModel user);

  Future<UserModel?> getUser(String uId);

  Future<bool> userExists(String uId);

  Future<bool> updateUser(UserModel user);

  Future<bool> deleteUser(String userId);
}
