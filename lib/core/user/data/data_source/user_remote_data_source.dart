import '../model/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<void> createUser(UserModel user);

  Future<UserModel> getUser(String uId);

  Future<bool> userExists(String uId);

  Future<void> updateUser(UserModel user);

  Future<void> deleteUser(String userId);
}
