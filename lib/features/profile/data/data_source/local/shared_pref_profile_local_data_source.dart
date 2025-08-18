import 'package:injectable/injectable.dart';
import 'package:sawa/core/helpers/shared_preferences_helper.dart';
import 'package:sawa/core/utils/enums.dart';
import 'package:sawa/features/profile/data/data_source/local/interface/i_profile_local_data_source.dart';

@LazySingleton(as: IProfileLocalDataSource)
class SharedPrefProfileLocalDataSource implements IProfileLocalDataSource {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  SharedPrefProfileLocalDataSource(this._sharedPreferencesHelper);

  @override
  Future<void> updateProfileBio({required String newBio}) async {
    await _sharedPreferencesHelper.storeString(UserInfo.bio.asString, newBio);
  }

  @override
  Future<void> updateProfileName({required String newName}) async {
    await _sharedPreferencesHelper.storeString(UserInfo.name.asString, newName);
  }

  @override
  Future<void> updateProfileImage({required String path}) async {
    await _sharedPreferencesHelper.storeString(UserInfo.image.asString, path);
  }
}
