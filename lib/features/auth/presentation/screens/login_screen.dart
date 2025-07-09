import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Text('label', style: AppStyles.s15W400),
              TextFormField(
                controller: TextEditingController(),
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
