import 'package:json_annotation/json_annotation.dart';

import '../../../features/home/domain/entities/post_entity.dart';
import '../../../features/user/data/model/user_model.dart';
import 'post_media_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel {
  final String id;
  @JsonKey(name: 'user_id')
  final String authorId;
  final String content;
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(defaultValue: [])
  final List<PostMediaModel> media;
  final UserModel author;

  const PostModel({
    required this.id,
    required this.authorId,
    required this.content,
    required this.isPublic,
    required this.createdAt,
    required this.media,
    required this.author,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id']?.toString() ?? '',
      authorId: json['user_id']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      isPublic: json['is_public'] as bool? ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      media: json['media'] is List
          ? (json['media'] as List).map((item) {
              return PostMediaModel.fromJson(
                item is Map<String, dynamic>
                    ? item
                    : Map<String, dynamic>.from(item as Map? ?? {}),
              );
            }).toList()
          : <PostMediaModel>[],
      author: json['author'] != null
          ? UserModel.fromJson(
              json['author'] is Map<String, dynamic>
                  ? json['author'] as Map<String, dynamic>
                  : Map<String, dynamic>.from(json['author'] as Map? ?? {}),
            )
          : UserModel.empty(),
    );
  }

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      authorId: authorId,
      content: content,
      isPublic: isPublic,
      createdAt: createdAt,
      media: media.map((e) => e.toEntity()).toList(),
      author: author.toEntity(),
    );
  }

  PostModel copyWith({
    String? id,
    String? authorId,
    String? content,
    bool? isPublic,
    DateTime? createdAt,
    List<PostMediaModel>? media,
    UserModel? author,
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
}
