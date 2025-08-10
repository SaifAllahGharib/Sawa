import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/helpers/shared_preferences_helper.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';
import 'package:intern_intelligence_social_media_application/features/profile/data/data_source/profile_local_data_source.dart';

@LazySingleton(as: IProfileLocalDataSource)
class SharedPrefProfileLocalDataSource implements IProfileLocalDataSource {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  SharedPrefProfileLocalDataSource(this._sharedPreferencesHelper);

  @override
  Future<void> updateProfileBio(String newBio) async {
    await _sharedPreferencesHelper.storeString(UserInfo.bio.asString, newBio);
  }

  @override
  Future<void> updateProfileName(String newName) async {
    await _sharedPreferencesHelper.storeString(UserInfo.name.asString, newName);
  }

  @override
  Future<void> uploadProfileImage(String path) async {
    await _sharedPreferencesHelper.storeString(UserInfo.image.asString, path);
  }
}
