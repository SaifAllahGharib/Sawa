import 'package:sawa/features/user/data/model/user_model.dart';

abstract class IUserLocalDataSource {
  UserModel? getUser();

  Future<void> saveUser(UserModel user);
}
