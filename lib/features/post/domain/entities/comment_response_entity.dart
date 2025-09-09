import '../../../user/data/model/user_model.dart';

class CommentResponseEntity {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final UserModel user;
  final DateTime createdAt;

  CommentResponseEntity({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.user,
    required this.createdAt,
  });
}
