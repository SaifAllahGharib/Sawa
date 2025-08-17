import 'package:flutter/material.dart';

class AppSnackBar {
  const AppSnackBar._();

  static const int _milliseconds = 2400;

  static void showSuccess(
    BuildContext context,
    String message, {
    int milliseconds = _milliseconds,
  }) {
    _showSnackBar(
      context,
      message,
      milliseconds,
      backgroundGradient: const LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      progressColor: Colors.white,
      icon: Icons.check_circle_rounded,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    int milliseconds = _milliseconds,
  }) {
    _showSnackBar(
      context,
      message,
      milliseconds,
      backgroundGradient: const LinearGradient(
        colors: [Color(0xFFE53935), Color(0xFFB71C1C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      progressColor: Colors.white,
      icon: Icons.error_rounded,
    );
  }

  static void _showSnackBar(
    BuildContext context,
    String message,
    int milliseconds, {
    required Gradient backgroundGradient,
    required Color progressColor,
    required IconData icon,
  }) {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: milliseconds),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 18,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                AnimatedOpacity(
                  opacity: 1,
                  duration: const Duration(milliseconds: 500),
                  child: Icon(icon, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: milliseconds),
                tween: Tween(begin: 1.0, end: 0.0),
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 4,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation(progressColor),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
