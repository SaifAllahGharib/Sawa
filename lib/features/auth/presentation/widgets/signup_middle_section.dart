import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_state.dart';
import 'package:intern_intelligence_social_media_application/core/utils/validators.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class SignupMiddleSection extends StatefulWidget {
  const SignupMiddleSection({super.key});

  @override
  State<SignupMiddleSection> createState() => _SignupMiddleSectionState();
}

class _SignupMiddleSectionState extends State<SignupMiddleSection> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  String? _errorMsg(bool? value, String msg) {
    return value != null ? (value ? null : msg) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<ValidationCubit, ValidationState, bool?>(
          selector: (state) => state.fieldsValidity['name'],
          builder: (context, nameIsValid) {
            return AppTextFormField(
              controller: _nameController,
              label: context.tr.labelName,
              hint: context.tr.hintName,
              error: _errorMsg(nameIsValid, context.tr.required),
              onChanged: (value) {
                context.read<ValidationCubit>().validateField(
                  'name',
                  value.isNotEmpty,
                );
              },
            );
          },
        ),
        10.verticalSpace,
        BlocSelector<ValidationCubit, ValidationState, bool?>(
          selector: (state) => state.fieldsValidity['email'],
          builder: (context, emailIsValid) {
            return AppTextFormField(
              controller: _emailController,
              label: context.tr.labelEmail,
              hint: context.tr.hintEmail,
              error: _errorMsg(emailIsValid, context.tr.emailNotValid),
              onChanged: (email) {
                context.read<ValidationCubit>().validateField(
                  'email',
                  emailValidator(email),
                );
              },
            );
          },
        ),
        10.verticalSpace,
        BlocSelector<ValidationCubit, ValidationState, bool?>(
          selector: (state) => state.fieldsValidity['password'],
          builder: (context, passwordIsValid) {
            return AppTextFormField(
              controller: _passwordController,
              label: context.tr.labelPassword,
              hint: context.tr.hintPassword,
              error: _errorMsg(
                passwordIsValid,
                context.tr.passwordValidationMsg,
              ),
              onChanged: (password) {
                context.read<ValidationCubit>().validateField(
                  'password',
                  passwordValidator(password),
                );
              },
            );
          },
        ),
        20.verticalSpace,
        BlocSelector<ValidationCubit, ValidationState, bool>(
          selector: (state) => state.enableButton,
          builder: (context, enableButton) {
            return AppButton(
              onClick: () {},
              text: context.tr.signup,
              enabled: enableButton,
            );
          },
        ),
      ],
    );
  }
}
