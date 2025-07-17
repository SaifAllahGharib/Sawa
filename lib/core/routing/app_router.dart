import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/profile/%20presentation/screen/profile_screen.dart';

import '../../features/auth/presentation/cubits/verification/verification/verification_cubit.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/verification_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../di/dependency_injection.dart';
import 'app_route_name.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRouteName.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case AppRouteName.verification:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<VerificationCubit>(),
            child: const VerificationScreen(),
          ),
          settings: settings,
        );
      case AppRouteName.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
          settings: settings,
        );
      case AppRouteName.profile:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
          settings: settings,
        );
      default:
        debugPrint('Unknown Route: ${settings.name}');
        return _errorRoute();
    }
  }

  static MaterialPageRoute _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Unknown Route')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
