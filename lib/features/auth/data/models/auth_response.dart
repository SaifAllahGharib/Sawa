import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final String? access_token;
  final String? refresh_token;
  final String? token_type;
  final int? expires_in;
  final Map<String, dynamic>? user;

  AuthResponse({
    this.access_token,
    this.refresh_token,
    this.token_type,
    this.expires_in,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
