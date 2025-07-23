import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_media_entity.dart';

class PostEntity {
  final String? id;
  final String authorId;
  final String? content;
  final List<PostMediaEntity>? media;
  final bool isPublic;
  final DateTime? createdAt;

  PostEntity({
    this.id,
    required this.authorId,
    this.content,
    this.media,
    required this.isPublic,
    this.createdAt,
  });
}
