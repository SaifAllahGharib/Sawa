import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/routing/app_route_name.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/screens/login_screen.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/screens/signup_screen.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRouteName.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Unknown Route')),
            body: const Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
