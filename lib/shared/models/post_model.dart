import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../features/home/data/models/post_media_model.dart';
import '../../features/home/domain/entities/post_entity.dart';
import '../../features/user/data/model/user_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel extends Equatable {
  final String id;
  @JsonKey(name: 'user_id')
  final String authorId;
  final String? content;
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<PostMediaModel>? media;
  final UserModel? author;

  const PostModel({
    required this.id,
    required this.authorId,
    this.content,
    required this.isPublic,
    required this.createdAt,
    this.media,
    this.author,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id ?? '',
      authorId: entity.authorId,
      isPublic: entity.isPublic,
      createdAt: entity.createdAt,
      content: entity.content,
      media: entity.media.map((e) => PostMediaModel.fromEntity(e)).toList(),
    );
  }

  PostModel copyWith({
    final String? id,
    final String? authorId,
    final String? content,
    final bool? isPublic,
    final DateTime? createdAt,
    final List<PostMediaModel>? media,
    final UserModel? author,
  }) {
    return PostModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      media: media ?? this.media,
      author: author ?? this.author,
    );
  }

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      authorId: authorId,
      content: content ?? '',
      isPublic: isPublic,
      createdAt: createdAt,
      media: media?.map((e) => e.toEntity()).toList() ?? [],
      author: author!.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    content,
    authorId,
    isPublic,
    createdAt,
    media,
    author,
  ];
}
