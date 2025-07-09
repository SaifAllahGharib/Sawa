import 'package:equatable/equatable.dart';

class ValidationState extends Equatable {
  final Map<String, bool?> fieldsValidity;
  final bool enableButton;

  const ValidationState({
    this.fieldsValidity = const {},
    this.enableButton = false,
  });

  ValidationState copyWith({
    Map<String, bool?>? fieldsValidity,
    bool? enableButton,
  }) {
    return ValidationState(
      fieldsValidity: fieldsValidity ?? this.fieldsValidity,
      enableButton: enableButton ?? this.enableButton,
    );
  }

  @override
  List<Object?> get props => [fieldsValidity, enableButton];
}
