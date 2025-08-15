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
    required this.name,
    required this.email,
    this.image,
    this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.empty() => const UserModel(id: '', name: '', email: '');

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, email: email, image: image, bio: bio);
  }
}
