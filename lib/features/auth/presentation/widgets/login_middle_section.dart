import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_state.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class LoginMiddleSection extends StatefulWidget {
  const LoginMiddleSection({super.key});

  @override
  State<LoginMiddleSection> createState() => _LoginMiddleSectionState();
}

class _LoginMiddleSectionState extends State<LoginMiddleSection> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ValidationCubit>(),
      child: Column(
        children: [
          BlocSelector<ValidationCubit, ValidationState, bool?>(
            selector: (state) => state.isEmailValid,
            builder: (context, emailIsValid) {
              return AppTextFormField(
                controller: _emailController,
                label: context.tr.labelEmail,
                hint: context.tr.hintEmail,
                error: emailIsValid != null
                    ? (emailIsValid ? null : context.tr.emailNotValid)
                    : null,
                onChanged: (email) {
                  context.read<ValidationCubit>().validateEmail(email);
                },
              );
            },
          ),
          10.verticalSpace,
          BlocSelector<ValidationCubit, ValidationState, bool?>(
            selector: (state) => state.isPasswordValid,
            builder: (context, passwordIsValid) {
              return AppTextFormField(
                controller: _passwordController,
                label: context.tr.labelPassword,
                hint: context.tr.hintPassword,
                error: passwordIsValid != null
                    ? (passwordIsValid
                          ? null
                          : context.tr.passwordValidationMsg)
                    : null,
                onChanged: (password) {
                  context.read<ValidationCubit>().validatePassword(password);
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
                text: context.tr.login,
                enabled: enableButton,
              );
            },
          ),
        ],
      ),
    );
  }
}
