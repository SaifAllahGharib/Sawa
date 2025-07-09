import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import 'app_route_name.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRouteName.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case AppRouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
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
