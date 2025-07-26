import 'package:intern_intelligence_social_media_application/core/user/domain/entity/user_entity.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';

class ProfileEntity {
  final UserEntity user;
  final List<PostEntity> posts;

  ProfileEntity({required this.user, required this.posts});
}
