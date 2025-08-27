import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';

import '../enums/text_form_type.dart';
import '../styles/app_styles.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String hint;
  final String? error;
  final bool? enabled;
  final bool enabledLabel;
  final TextInputType keyboardType;
  final TextFormType textFormType;
  final void Function(String value)? onChanged;

  const AppTextFormField({
    super.key,
    required this.controller,
    this.label,
    required this.hint,
    this.error,
    this.onChanged,
    this.enabled,
    this.enabledLabel = true,
    this.keyboardType = TextInputType.text,
    this.textFormType = TextFormType.text,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final ValueNotifier<bool> _valueNotifier;

  @override
  void initState() {
    _valueNotifier = ValueNotifier(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.enabledLabel)
          Text(widget.label ?? '', style: AppStyles.s15W400),
        if (widget.enabledLabel) 6.verticalSpace,
        ValueListenableBuilder(
          valueListenable: _valueNotifier,
          builder: (context, value, child) {
            return TextFormField(
              controller: widget.controller,
              enabled: widget.enabled,
              keyboardType: widget.keyboardType,
              obscureText: widget.textFormType == TextFormType.password
                  ? value
                  : false,
              obscuringCharacter: '○',
              decoration: InputDecoration(
                hintText: widget.hint,
                errorText: widget.error,
                suffixIcon: widget.textFormType == TextFormType.password
                    ? AppGestureDetectorButton(
                        onTap: () => _valueNotifier.value = !value,
                        child: Icon(
                          value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      )
                    : null,
              ),
              onChanged: widget.onChanged,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            );
          },
        ),
      ],
    );
  }
}
