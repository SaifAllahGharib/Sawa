// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentRequestModel _$CommentRequestModelFromJson(Map<String, dynamic> json) =>
    CommentRequestModel(
      postId: json['postId'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$CommentRequestModelToJson(
  CommentRequestModel instance,
) => <String, dynamic>{'postId': instance.postId, 'content': instance.content};
