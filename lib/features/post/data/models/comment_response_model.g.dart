// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponseModel _$CommentResponseModelFromJson(
  Map<String, dynamic> json,
) => CommentResponseModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  postId: json['postId'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$CommentResponseModelToJson(
  CommentResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'postId': instance.postId,
  'userId': instance.userId,
  'content': instance.content,
  'user': instance.user,
  'createdAt': instance.createdAt.toIso8601String(),
};
