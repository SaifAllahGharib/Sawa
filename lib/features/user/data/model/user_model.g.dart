// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  image: json['image'] as String?,
  name: json['name'] as String,
  email: json['email'] as String,
  bio: json['bio'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'image': instance.image,
  'name': instance.name,
  'email': instance.email,
  'bio': instance.bio,
};
