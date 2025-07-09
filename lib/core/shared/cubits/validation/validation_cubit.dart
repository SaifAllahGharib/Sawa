import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  final Set<String> requiredFields;

  ValidationCubit({required this.requiredFields})
    : super(const ValidationState());

  void validateField(String fieldName, bool isValid) {
    final updatedValidity = Map<String, bool?>.from(state.fieldsValidity)
      ..[fieldName] = isValid;

    final allFieldsPresent = updatedValidity.keys.toSet().containsAll(
      requiredFields,
    );
    final allValid = updatedValidity.entries
        .where((entry) => requiredFields.contains(entry.key))
        .every((entry) => entry.value ?? false);

    emit(
      state.copyWith(
        fieldsValidity: updatedValidity,
        enableButton: allFieldsPresent && allValid,
      ),
    );
  }
}
