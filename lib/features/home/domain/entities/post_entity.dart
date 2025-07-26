import '../../../../core/user/domain/entity/user_entity.dart';
import 'post_media_entity.dart';

class PostEntity {
  final String? id;
  final String authorId;
  final String content;
  final List<PostMediaEntity> media;
  final bool isPublic;
  final DateTime createdAt;
  final UserEntity? author;

  PostEntity({
    this.id,
    required this.authorId,
    this.content = '',
    this.media = const [],
    required this.isPublic,
    required this.createdAt,
    this.author,
  });
}
