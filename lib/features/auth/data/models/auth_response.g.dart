// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  access_token: json['access_token'] as String?,
  refresh_token: json['refresh_token'] as String?,
  token_type: json['token_type'] as String?,
  expires_in: (json['expires_in'] as num?)?.toInt(),
  user: json['user'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'user': instance.user,
    };
