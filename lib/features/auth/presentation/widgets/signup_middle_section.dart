import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/routing/app_route_name.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_state.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/signup/signup_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/signup/signup_state.dart';

import '../../../../core/utils/app_reg_exp.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_button_loading.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../domain/entities/signup_entity.dart';

class SignupMiddleSection extends StatefulWidget {
  const SignupMiddleSection({super.key});

  @override
  State<SignupMiddleSection> createState() => _SignupMiddleSectionState();
}

class _SignupMiddleSectionState extends State<SignupMiddleSection> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isLoading = false;

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

  void _signup() {
    context.read<SignupCubit>().signup(
      SignupEntity(
        name: _nameController.text,
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  void _whenLoading() {
    _isLoading = true;
    FocusScope.of(context).unfocus();
  }

  void _whenSuccess() {
    setState(() {
      _isLoading = false;
    });
    context.navigator.pushNamed(
      AppRouteName.verification,
      arguments: {
        'name': _nameController.text,
        'email': _emailController.text.trim(),
      },
    );
  }

  void _whenFailure(String code) {
    setState(() {
      _isLoading = false;
    });
    if (code == 'email_in_use' || code == 'uid_exists') {
      AppSnackBar.showError(context, context.tr.email_already_used);
    } else if (code == 'internal_error') {
      AppSnackBar.showError(context, context.tr.errorToConnectTheNetwork);
    } else if (code == 'failed_to_store_user_in_db') {
      AppSnackBar.showError(context, context.tr.failedToStoreUserInDb);
    } else if (code == 'network_request_failed') {
      AppSnackBar.showError(context, context.tr.errorConnectionNetwork);
    } else if (code == 'failed to create user') {
      AppSnackBar.showError(context, context.tr.failedToCreateUser);
    } else if (code == 'auth_error') {
      AppSnackBar.showError(context, context.tr.unknownError);
    } else {
      AppSnackBar.showError(context, code);
    }
  }

  void _handleState(SignupState state) {
    if (state is SignupLoadingState) {
      _whenLoading();
    } else if (state is SignupSuccessState) {
      _whenSuccess();
    } else if (state is SignupFailureState) {
      _whenFailure(state.code);
    }
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
              enabled: !_isLoading,
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
              keyboardType: TextInputType.emailAddress,
              enabled: !_isLoading,
              error: _errorMsg(emailIsValid, context.tr.emailNotValid),
              onChanged: (email) {
                context.read<ValidationCubit>().validateField(
                  'email',
                  AppRegExp.emailValidator(email),
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
              textFormType: TextFormType.password,
              enabled: !_isLoading,
              error: _errorMsg(
                passwordIsValid,
                context.tr.passwordValidationMsg,
              ),
              onChanged: (password) {
                context.read<ValidationCubit>().validateField(
                  'password',
                  AppRegExp.passwordValidator(password),
                );
              },
            );
          },
        ),
        20.verticalSpace,
        BlocBuilder<ValidationCubit, ValidationState>(
          builder: (context, validationState) {
            return BlocConsumer<SignupCubit, SignupState>(
              listener: (context, state) => _handleState(state),
              builder: (context, state) {
                if (state is SignupLoadingState) {
                  return const AppButtonLoading();
                }

                return AppButton(
                  onClick: _signup,
                  text: context.tr.signup,
                  enabled: validationState.enableButton,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
