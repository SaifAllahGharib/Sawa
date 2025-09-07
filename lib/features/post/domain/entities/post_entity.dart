import '../../../user/domain/entity/user_entity.dart';
import 'post_media_entity.dart';

class PostEntity {
  final String id;
  final String authorId;
  final String content;
  final List<PostMediaEntity> media;
  final bool isPublic;
  final DateTime createdAt;
  final UserEntity author;

  PostEntity({
    required this.id,
    required this.authorId,
    required this.content,
    required this.media,
    required this.isPublic,
    required this.createdAt,
    required this.author,
  });
}
