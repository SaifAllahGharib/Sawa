import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_media_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_media_model.g.dart';

@JsonSerializable()
class PostMediaModel {
  @JsonKey(name: 'post_id')
  final String postId;
  @JsonKey(name: 'media_url')
  final String mediaUrl;
  @JsonKey(name: 'media_type')
  final String mediaType;

  PostMediaModel({
    required this.postId,
    required this.mediaUrl,
    required this.mediaType,
  });

  factory PostMediaModel.fromJson(Map<String, dynamic> json) =>
      _$PostMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostMediaModelToJson(this);

  factory PostMediaModel.fromEntity(PostMediaEntity postMedia) {
    return PostMediaModel(
      postId: postMedia.postId,
      mediaUrl: postMedia.mediaUrl,
      mediaType: postMedia.mediaType,
    );
  }

  PostMediaEntity toEntity() {
    return PostMediaEntity(
      postId: postId,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
    );
  }
}
