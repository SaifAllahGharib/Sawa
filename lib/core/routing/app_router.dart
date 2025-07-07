import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
