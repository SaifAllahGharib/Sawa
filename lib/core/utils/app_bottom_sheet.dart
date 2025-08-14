import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';

abstract class AppBottomSheet {
  static void show(
    BuildContext context,
    WidgetBuilder builder, [
    ShapeBorder? shape,
    bool showDragHandle = true,
    bool enableDrag = true,
  ]) {
    showBottomSheet(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
      showDragHandle: showDragHandle,
      enableDrag: enableDrag,
      context: context,
      builder: builder,
    );
  }

  static void showModal(
    BuildContext context,
    WidgetBuilder builder, [
    ShapeBorder? shape,
    bool enableDrag = true,
    bool isDismissible = true,
    bool showDragHandle = true,
  ]) {
    showModalBottomSheet(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      showDragHandle: showDragHandle,
      context: context,
      builder: builder,
    );
  }
}
