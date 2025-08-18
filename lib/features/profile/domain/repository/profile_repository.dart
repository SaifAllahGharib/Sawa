import 'package:failure_handler/failure_handler.dart';
import 'package:sawa/features/profile/domain/entity/profile_entity.dart';

import '../../../../shared/models/media_model.dart';

abstract class IProfileRepository {
  FutureResult<void> updateProfileName({required String newName});

  FutureResult<void> updateProfileBio({required String newBio});

  FutureResult<ProfileEntity> getProfile({required String uId});

  FutureResult<void> deletePost({required String postId});

  FutureResult<void> updateProfileImage({required MediaModel mediaModel});
}
