// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupModel _$SignupModelFromJson(Map<String, dynamic> json) => SignupModel(
  name: json['name'] as String,
  identifier: json['identifier'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$SignupModelToJson(SignupModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'identifier': instance.identifier,
      'password': instance.password,
    };
