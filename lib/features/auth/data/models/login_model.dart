import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String identifier;
  final String password;

  const LoginModel({required this.identifier, required this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  LoginEntity toEntity() {
    return LoginEntity(identifier: identifier, password: password);
  }
}
