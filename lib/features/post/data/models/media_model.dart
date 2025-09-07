import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_model.g.dart';

@JsonSerializable()
class MediaModel {
  final String path;
  final String type;

  MediaModel({required this.path, required this.type});

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}
