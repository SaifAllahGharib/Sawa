import 'package:json_annotation/json_annotation.dart';

import 'media_model.dart';

part 'create_post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatePostModel {
  @JsonKey(name: 'user_id')
  final String authorId;
  final String content;
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<MediaModel> media;

  const CreatePostModel({
    required this.authorId,
    required this.content,
    required this.isPublic,
    required this.createdAt,
    required this.media,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostModelToJson(this);

  CreatePostModel copyWith({
    String? content,
    bool? isPublic,
    List<MediaModel>? media,
  }) {
    return CreatePostModel(
      authorId: authorId,
      content: content ?? this.content,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt,
      media: media ?? this.media,
    );
  }
}
