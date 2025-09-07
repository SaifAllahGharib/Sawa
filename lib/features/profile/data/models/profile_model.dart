import 'package:json_annotation/json_annotation.dart';

import '../../../post/data/models/post_model.dart';
import '../../../user/data/model/user_model.dart';
import '../../domain/entity/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final UserModel user;
  final List<PostModel> posts;

  ProfileModel({required this.user, required this.posts});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileEntity toEntity() {
    return ProfileEntity(
      user: user.toEntity(),
      posts: posts.map((e) => e.toEntity()).toList(),
    );
  }
}
