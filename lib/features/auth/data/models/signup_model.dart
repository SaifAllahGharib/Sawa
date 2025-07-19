import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/signup_entity.dart';

part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel {
  final String name;
  final String email;
  final String password;

  const SignupModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);

  factory SignupModel.fromEntity(SignupEntity entity) {
    return SignupModel(
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
  }

  SignupEntity toEntity() {
    return SignupEntity(name: name, email: email, password: password);
  }
}
