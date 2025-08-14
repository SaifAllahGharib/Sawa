import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/constants/strings.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/styles/app_styles.dart';
import 'package:sawa/core/widgets/app_scaffold.dart';

import '../../../../core/routing/app_route_name.dart';
import '../../../../core/utils/enums.dart';
import '../../../../shared/cubits/main/main_cubit.dart';
import '../../../../shared/cubits/main/main_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _handleState(BuildContext context, MainState state) async {
    final authStatus = state.authState.status;

    final route = (authStatus == AuthStatus.authenticated)
        ? AppRouteName.home
        : AppRouteName.login;

    await Future.delayed(const Duration(milliseconds: 2000), () {
      if (context.mounted) {
        context.navigator.pushNamedAndRemoveUntil(route, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) => _handleState(context, state),
      child: AppScaffold(
        backgroundColor: context.theme.primaryColor,
        child: Center(
          child: Text(
            AppStrings.appName,
            style: AppStyles.s35WB.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
