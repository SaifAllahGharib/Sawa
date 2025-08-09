// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['id'] as String,
  authorId: json['user_id'] as String,
  content: json['content'] as String?,
  isPublic: json['is_public'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  media: (json['media'] as List<dynamic>?)
      ?.map((e) => PostMediaModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  author: json['author'] == null
      ? null
      : UserModel.fromJson(json['author'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.authorId,
  'content': instance.content,
  'is_public': instance.isPublic,
  'created_at': instance.createdAt.toIso8601String(),
  'media': instance.media?.map((e) => e.toJson()).toList(),
  'author': instance.author?.toJson(),
};
