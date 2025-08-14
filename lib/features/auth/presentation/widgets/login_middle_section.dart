import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/clients/firebase_client.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/utils/app_reg_exp.dart';
import 'package:sawa/core/widgets/app_button_loading.dart';
import 'package:sawa/features/auth/data/models/login_model.dart';
import 'package:sawa/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:sawa/features/auth/presentation/cubits/login/login_state.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/routing/app_route_name.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../shared/cubits/validation/validation_cubit.dart';
import '../../../../shared/cubits/validation/validation_state.dart';

class LoginMiddleSection extends StatefulWidget {
  const LoginMiddleSection({super.key});

  @override
  State<LoginMiddleSection> createState() => _LoginMiddleSectionState();
}

class _LoginMiddleSectionState extends State<LoginMiddleSection> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FirebaseClient _firebaseClient;
  bool _isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firebaseClient = getIt<FirebaseClient>();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  String? _errorMsg(bool? value, String msg) {
    return value != null ? (value ? null : msg) : null;
  }

  void _login() {
    context.read<LoginCubit>().login(
      LoginModel(
        identifier: _emailController.text.trim(),
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

    if (_firebaseClient.auth.currentUser!.emailVerified) {
      context.navigator.pushNamedAndRemoveUntil(
        AppRouteName.home,
        (route) => false,
      );
    } else {
      context.navigator.pushNamed(
        AppRouteName.verification,
        arguments: {'name': '', 'email': _emailController.text.trim()},
      );
    }
  }

  void _whenFailure(String code) {
    setState(() {
      _isLoading = false;
    });
    if (code == 'user_not_found' || code == 'invalid_credential') {
      AppSnackBar.showError(context, context.tr.userNotFound);
    } else if (code == 'internal_error') {
      AppSnackBar.showError(context, context.tr.errorToConnectTheNetwork);
    } else if (code == 'network_request_failed') {
      AppSnackBar.showError(context, context.tr.errorConnectionNetwork);
    } else if (code == 'auth_error') {
      AppSnackBar.showError(context, context.tr.unknownError);
    } else {
      AppSnackBar.showError(context, code);
    }
  }

  void _handleState(LoginState state) {
    if (state is LoginLoadingState) {
      _whenLoading();
    } else if (state is LoginSuccessState) {
      _whenSuccess();
    } else if (state is LoginFailureState) {
      _whenFailure(state.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<ValidationCubit, ValidationState, bool?>(
          selector: (state) => state.fieldsValidity['email'],
          builder: (context, emailIsValid) {
            return AppTextFormField(
              controller: _emailController,
              label: context.tr.labelEmail,
              hint: context.tr.hintEmail,
              enabled: !_isLoading,
              keyboardType: TextInputType.emailAddress,
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
            return BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) => _handleState(state),
              builder: (context, state) {
                if (state is LoginLoadingState) return const AppButtonLoading();

                return AppButton(
                  onClick: _login,
                  text: context.tr.login,
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
