import 'package:equatable/equatable.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatePostModel extends Equatable {
  @JsonKey(name: 'user_id')
  final String authorId;
  final String? content;
  @JsonKey(name: 'is_public')
  final bool isPublic;

  const CreatePostModel({
    required this.authorId,
    this.content,
    required this.isPublic,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostModelToJson(this);

  CreatePostModel copyWith({
    String? content,
    String? authorId,
    bool? isPublic,
  }) {
    return CreatePostModel(
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      isPublic: isPublic ?? this.isPublic,
    );
  }

  factory CreatePostModel.fromEntity(PostEntity post) {
    return CreatePostModel(
      authorId: post.authorId,
      content: post.content,
      isPublic: post.isPublic,
    );
  }

  PostEntity toEntity() {
    return PostEntity(authorId: authorId, content: content, isPublic: isPublic);
  }

  @override
  List<Object?> get props => [content, authorId, isPublic];
}
