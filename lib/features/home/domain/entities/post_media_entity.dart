class PostMediaEntity {
  final String? id;
  final String postId;
  final String mediaUrl;
  final String mediaType;

  PostMediaEntity({
    this.id,
    required this.postId,
    required this.mediaUrl,
    required this.mediaType,
  });
}
