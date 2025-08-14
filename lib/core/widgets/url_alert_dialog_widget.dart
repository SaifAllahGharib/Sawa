import 'package:flutter/material.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';

import '../styles/app_styles.dart';

class UrlAlertDialogWidget extends StatelessWidget {
  final VoidCallback onClickOpen;
  final VoidCallback onClickCopy;

  const UrlAlertDialogWidget({
    super.key,
    required this.onClickOpen,
    required this.onClickCopy,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      title: Text(
        context.tr.link,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      content: Text(
        context.tr.doYouWantToOpenOrCopyTheLink,
        style: AppStyles.s16W500,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: context.theme.primaryColor,
            textStyle: AppStyles.s16W500,
          ),
          onPressed: onClickOpen,
          child: Text(context.tr.open),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: context.theme.colorScheme.secondary,
            textStyle: AppStyles.s16W500,
          ),
          onPressed: () {
            onClickCopy();
            Navigator.pop(context);
          },
          child: Text(context.tr.copy),
        ),
      ],
    );
  }
}
