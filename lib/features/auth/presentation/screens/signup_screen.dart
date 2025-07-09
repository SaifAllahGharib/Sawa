import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_remove_focus.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/widgets/signup_bottom_section.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/widgets/signup_middle_section.dart';

import '../widgets/signup_top_section.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ValidationCubit(requiredFields: {'name', 'email', 'password'}),
        ),
      ],
      child: AppScaffold(
        child: AppRemoveFocus(
          child: AppPaddingWidget(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SignupTopSection(),
                  20.verticalSpace,
                  const SignupMiddleSection(),
                  10.verticalSpace,
                  const SignupBottomSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
