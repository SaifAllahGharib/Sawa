import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/responsive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context) => const MaterialApp(
        home: Scaffold(body: Center(child: Text('TEsT'))),
      ),
    );
  }
}
