// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMediaModel _$PostMediaModelFromJson(Map<String, dynamic> json) =>
    PostMediaModel(
      postId: json['post_id'] as String,
      mediaUrl: json['media_url'] as String,
      mediaType: json['media_type'] as String,
    );

Map<String, dynamic> _$PostMediaModelToJson(PostMediaModel instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'media_url': instance.mediaUrl,
      'media_type': instance.mediaType,
    };
