// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reactio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionModel _$ReactionModelFromJson(Map<String, dynamic> json) =>
    ReactionModel(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ReactionModelToJson(ReactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'type': instance.type,
    };
