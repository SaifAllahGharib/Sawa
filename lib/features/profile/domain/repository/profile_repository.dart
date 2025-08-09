import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/features/profile/domain/entity/profile_entity.dart';

import '../../../home/domain/entities/media_entity.dart';

abstract class IProfileRepository {
  FutureResult<void> uploadProfileImage(MediaEntity media);

  FutureResult<void> updateProfileName(String newName);

  FutureResult<void> updateProfileBio(String newBio);

  FutureResult<ProfileEntity> getProfile(String uId);

  FutureResult<void> deletePost(String postId);
}
