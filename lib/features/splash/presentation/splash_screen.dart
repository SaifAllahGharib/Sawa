import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/enums/auth_status.dart';
import 'package:sawa/core/routing/app_route_name.dart';
import 'package:sawa/core/services/navigation/navigation_service.dart';
import 'package:sawa/shared/cubits/main/main_cubit.dart';
import 'package:sawa/shared/cubits/main/main_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<MainCubit>().checkAuthStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        if (state.authState.status == AuthStatus.authenticated) {
          NavigationService.I.offAllNamed(AppRouteName.home);
        } else {
          NavigationService.I.offAllNamed(AppRouteName.login);
        }
      },
      child: const Scaffold(),
    );
  }
}
