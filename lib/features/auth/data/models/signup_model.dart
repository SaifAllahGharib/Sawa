import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/signup_entity.dart';

part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel {
  final String name;
  final String identifier;
  final String password;

  const SignupModel({
    required this.name,
    required this.identifier,
    required this.password,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);

  SignupEntity toEntity() {
    return SignupEntity(name: name, identifier: identifier, password: password);
  }
}
