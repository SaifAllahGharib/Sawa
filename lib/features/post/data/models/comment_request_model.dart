import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_request_model.g.dart';

@JsonSerializable()
class CommentRequestModel {
  final String postId;
  final String content;

  CommentRequestModel({required this.postId, required this.content});

  factory CommentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CommentRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentRequestModelToJson(this);
}
