import 'package:sawa/features/post/data/models/media_model.dart';

import '../../../models/profile_model.dart';

abstract class IProfileRemoteDataSource {
  Future<void> updateProfileName({required String newName});

  Future<void> updateProfileBio({required String newBio});

  Future<ProfileModel> getProfile({required String uId});

  Future<void> deletePost({required String postId});

  Future<String> updateProfileImage({required MediaModel mediaModel});
}
