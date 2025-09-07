import '../../../post/domain/entities/post_entity.dart';
import '../../../user/domain/entity/user_entity.dart';

class ProfileEntity {
  final UserEntity user;
  final List<PostEntity> posts;

  ProfileEntity({required this.user, required this.posts});
}
