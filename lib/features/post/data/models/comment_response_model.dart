import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sawa/features/post/domain/entities/comment_response_entity.dart';
import 'package:sawa/features/user/data/model/user_model.dart';

part 'comment_response_model.g.dart';

@JsonSerializable()
class CommentResponseModel {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final UserModel user;
  final DateTime createdAt;

  CommentResponseModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.createdAt,
    required this.postId,
    required this.content,
  });

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseModelToJson(this);

  CommentResponseEntity toEntity() {
    return CommentResponseEntity(
      id: id,
      postId: postId,
      userId: userId,
      content: content,
      user: user,
      createdAt: createdAt,
    );
  }
}
