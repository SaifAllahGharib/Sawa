import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/number_extensions.dart';

class SuccessVerificationWidget extends StatefulWidget {
  const SuccessVerificationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SuccessVerificationWidgetState();
}

class _SuccessVerificationWidgetState extends State<SuccessVerificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 130.h),
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutBack,
        builder: (context, size, child) {
          return Icon(Icons.check, size: size, color: Colors.green);
        },
      ),
    );
  }
}
