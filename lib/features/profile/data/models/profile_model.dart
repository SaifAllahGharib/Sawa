import 'package:intern_intelligence_social_media_application/features/profile/domain/entity/profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../shared/models/post_model.dart';
import '../../../user/data/model/user_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final UserModel user;
  final List<PostModel> posts;

  ProfileModel({required this.user, required this.posts});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      user: UserModel.fromEntity(entity.user),
      posts: entity.posts.map((e) => PostModel.fromEntity(e)).toList(),
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      user: user.toEntity(),
      posts: posts.map((e) => e.toEntity()).toList(),
    );
  }
}
