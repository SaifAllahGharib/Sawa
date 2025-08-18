import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/reaction_entity.dart';

part 'reactio_model.g.dart';

@JsonSerializable()
class ReactionModel extends ReactionEntity {
  const ReactionModel({
    required super.id,
    required super.postId,
    required super.userId,
    required super.type,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> map) =>
      _$ReactionModelFromJson(map);

  Map<String, dynamic> toJson() => _$ReactionModelToJson(this);
}
