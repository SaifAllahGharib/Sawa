import 'package:flutter/cupertino.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';

abstract class DateTimeHelper {
  static String timeAgoSinceDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return context.tr.now;
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${context.tr.m}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${context.tr.h}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${context.tr.day}';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${context.tr.week}';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${context.tr.month}';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${context.tr.year}';
    }
  }
}
