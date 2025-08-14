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

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'] as String,
    authorId: json['user_id'] as String,
    content: json['content'] as String,
    isPublic: json['is_public'] as bool,
    createdAt: DateTime.parse(json['created_at'] as String),
    media: (json['media'] as List<dynamic>? ?? []).map((e) {
      final json2 = Map<String, dynamic>.from(e as Map);
      return PostMediaModel.fromJson(json2);
    }).toList(),
    author: json['author'] != null
        ? UserModel.fromJson(json['author'] as Map<String, dynamic>)
        : const UserModel(id: '', name: '', email: ''),
  );

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
    String? authorId,
    String? content,
    bool? isPublic,
    DateTime? createdAt,
    List<PostMediaModel>? media,
    UserModel? author,
  }) {
    return PostModel(
      id: id,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      media: media ?? this.media,
      author: author ?? this.author,
    );
  }
}
