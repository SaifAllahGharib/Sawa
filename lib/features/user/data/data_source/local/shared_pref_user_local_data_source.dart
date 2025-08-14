import 'package:injectable/injectable.dart';
import 'package:sawa/features/user/data/data_source/local/interface/i_user_local_data_source.dart';

import '../../../../../core/helpers/shared_preferences_helper.dart';
import '../../model/user_model.dart';

@LazySingleton(as: IUserLocalDataSource)
class SharedPrefUserLocalDataSource implements IUserLocalDataSource {
  final SharedPreferencesHelper prefs;

  SharedPrefUserLocalDataSource(this.prefs);

  @override
  UserModel? getUser() {
    return prefs.getUser();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await prefs.storeUser(user.toJson());
  }
}
