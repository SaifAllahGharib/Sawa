import '../../../model/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<void> createUser({required UserModel user});

  Future<UserModel> getUser({required String uId});

  Future<bool> userExists({required String uId});

  Future<void> updateUser({required UserModel user});

  Future<void> deleteUser({required String uId});
}
