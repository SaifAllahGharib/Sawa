import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String? image;
  final String name;
  final String email;
  final String? bio;

  const UserModel({
    required this.id,
    this.image,
    required this.name,
    required this.email,
    this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      image: user.image,
      bio: user.bio,
    );
  }

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, email: email, image: image, bio: bio);
  }
}
