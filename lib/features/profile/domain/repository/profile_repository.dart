import 'package:failure_handler/failure_handler.dart';
import 'package:intern_intelligence_social_media_application/features/profile/domain/entity/profile_entity.dart';

import '../../../home/domain/entities/media_entity.dart';

abstract class IProfileRepository {
  Future<Result<AppFailure, void>> uploadProfileImage(MediaEntity media);

  Future<Result<AppFailure, void>> updateProfileName(String newName);

  Future<Result<AppFailure, ProfileEntity>> getProfile();
}
