import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_remove_focus.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/login/login_cubit.dart';

import '../../../../core/shared/cubits/validation/validation_cubit.dart';
import '../widgets/login_bottom_section.dart';
import '../widgets/login_middle_section.dart';
import '../widgets/login_top_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ValidationCubit(requiredFields: {'email', 'password'}),
        ),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
      ],
      child: AppScaffold(
        child: AppPaddingWidget(
          child: AppRemoveFocus(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LoginTopSection(),
                  20.verticalSpace,
                  const LoginMiddleSection(),
                  10.verticalSpace,
                  const LoginBottomSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
