// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostModel _$CreatePostModelFromJson(Map<String, dynamic> json) =>
    CreatePostModel(
      authorId: json['user_id'] as String,
      content: json['content'] as String,
      isPublic: json['is_public'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      media: (json['media'] as List<dynamic>)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreatePostModelToJson(CreatePostModel instance) =>
    <String, dynamic>{
      'user_id': instance.authorId,
      'content': instance.content,
      'is_public': instance.isPublic,
      'created_at': instance.createdAt.toIso8601String(),
      'media': instance.media.map((e) => e.toJson()).toList(),
    };
