import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../styles/app_styles.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? error;
  final bool? enabled;
  final void Function(String value)? onChanged;

  const AppTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.error,
    this.onChanged,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.s15W400),
        6.verticalSpace,
        TextFormField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(hintText: hint, errorText: error),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
