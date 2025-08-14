import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';

import '../utils/app_snack_bar.dart';

class AppErrorListener extends StatefulWidget {
  final Widget child;

  const AppErrorListener({super.key, required this.child});

  @override
  State<AppErrorListener> createState() => _AppErrorListenerState();
}

class _AppErrorListenerState extends State<AppErrorListener> {
  @override
  void initState() {
    _setupErrorStream();
    super.initState();
  }

  void _setupErrorStream() {
    FlutterError.onError = (FlutterErrorDetails details) async {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      _showSnackBar(context.tr.somethingWentWrong);
    };
  }

  void _showSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppSnackBar.showError(context, message, milliseconds: 4000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
