import 'package:json_annotation/json_annotation.dart';

import '../../features/home/domain/entities/post_media_entity.dart';

part 'post_media_model.g.dart';

@JsonSerializable()
class PostMediaModel {
  final String id;
  @JsonKey(name: 'post_id')
  final String postId;
  @JsonKey(name: 'media_url')
  final String mediaUrl;
  @JsonKey(name: 'media_type')
  final String mediaType;

  PostMediaModel({
    required this.id,
    required this.postId,
    required this.mediaUrl,
    required this.mediaType,
  });

  factory PostMediaModel.fromJson(Map<String, dynamic> json) =>
      _$PostMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostMediaModelToJson(this);

  PostMediaEntity toEntity() {
    return PostMediaEntity(
      id: id,
      postId: postId,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
    );
  }
}
