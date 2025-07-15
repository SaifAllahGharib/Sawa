import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_snack_bar.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/verification/verification/verification_state.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/routing/app_route_name.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubits/verification/verification/verification_cubit.dart';
import '../widgets/success_verification_widget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final FirebaseClient _firebaseClient;
  Timer? _timer;

  @override
  void initState() {
    _firebaseClient = getIt<FirebaseClient>();
    _sendEmailVerification();
    _startVerificationListener();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _sendEmailVerification() {
    context.read<VerificationCubit>().sendEmailVerification();
  }

  Future<void> _isEmailVerified(Timer timer) async {
    final user = _firebaseClient.auth.currentUser;
    await user?.reload();
    if (user != null && user.emailVerified && mounted) {
      context.read<VerificationCubit>().emailVerified();
      timer.cancel();
    }
  }

  void _startVerificationListener() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (timer) async => await _isEmailVerified(timer),
    );
  }

  void _whenSuccess() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      context.navigator.pushNamedAndRemoveUntil(
        AppRouteName.home,
        (route) => false,
      );
    });
  }

  void _whenCodeSendSuccess() {
    AppSnackBar.showSuccess(context, context.tr.codeSendSuccess);
  }

  void _whenFailure(String errorCode) {
    AppSnackBar.showError(context, errorCode);
  }

  void _whenSendCodeFailure() {
    AppSnackBar.showError(context, context.tr.codeSendNotSuccess);
  }

  void _handleState(VerificationState state) {
    if (state is VerificationSuccess) {
      _whenSuccess();
    } else if (state is VerificationCodeSentSuccessOnce) {
      _whenCodeSendSuccess();
    } else if (state is VerificationFailure) {
      if (state.errorCode == 'send email failed') {
        _whenSendCodeFailure();
      } else {
        _whenFailure(state.errorCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppPaddingWidget(
        child: BlocConsumer<VerificationCubit, VerificationState>(
          listener: (context, state) => _handleState(state),
          builder: (context, state) {
            if (state is VerificationSuccess) {
              return const SuccessVerificationWidget();
            }

            final time = (state is VerificationCodeSent) ? state.time : 0;
            final canSend = (state is VerificationCodeSent)
                ? state.canSend
                : false;

            return Padding(
              padding: EdgeInsets.all(20.r),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    30.verticalSpace,
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 20.w,
                      runSpacing: 3.h,
                      children: [
                        Text(
                          context.tr.sendLinkVerificationYourEmailTo,
                          style: AppStyles.s16W500,
                        ),
                        Text(
                          context.arguments as String,
                          style: AppStyles.s12W400.copyWith(
                            color: context.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Image.asset(AppAssets.verify),
                    const Spacer(),
                    AppButton(
                      text: time != 0 ? '${time}s' : context.tr.resendEmail,
                      enabled: canSend,
                      onClick: () async => _sendEmailVerification(),
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
