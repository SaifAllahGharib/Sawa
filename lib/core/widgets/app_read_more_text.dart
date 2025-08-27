import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';

import '../styles/app_colors.dart';
import '../styles/app_styles.dart';
import '../utils/app_reg_exp.dart';

class AppReadMoreText extends StatelessWidget {
  final String content;
  final int numberOfLines;
  final VoidCallback? onClickHashtag;
  final VoidCallback? onClickMention;
  final Function(String url)? onClickUrl;

  const AppReadMoreText({
    super.key,
    required this.content,
    this.onClickHashtag,
    this.onClickMention,
    this.onClickUrl,
    this.numberOfLines = 10,
  });

  TextDirection _detectTextDirection(String text) {
    final arabicCount = RegExp(r'[\u0600-\u06FF]').allMatches(text).length;
    final latinCount = RegExp(r'[A-Za-z]').allMatches(text).length;
    return arabicCount > latinCount ? TextDirection.rtl : TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      content,
      textAlign: TextAlign.start,
      textDirection: _detectTextDirection(content),
      trimMode: TrimMode.Line,
      trimLines: numberOfLines,
      trimExpandedText: '\u00A0${context.tr.showLess}',
      trimCollapsedText: '\u00A0${context.tr.showMore}',
      moreStyle: AppStyles.s14W400.copyWith(color: Colors.blue),
      lessStyle: AppStyles.s14W400.copyWith(color: Colors.blue),
      annotations: [
        Annotation(
          regExp: AppRegExp.hashtags,
          spanBuilder: ({required text, textStyle}) {
            return _buildTextSpan(
              text: text,
              textStyle: textStyle,
              onClick: onClickHashtag,
            );
          },
        ),
        Annotation(
          regExp: AppRegExp.mention,
          spanBuilder: ({required text, textStyle}) {
            return _buildTextSpan(
              text: text,
              textStyle: textStyle,
              onClick: onClickMention,
            );
          },
        ),
        Annotation(
          regExp: AppRegExp.url,
          spanBuilder: ({required text, textStyle}) {
            return _buildTextSpan(
              text: text,
              textStyle: textStyle?.copyWith(
                decoration: TextDecoration.underline,
              ),
              onClick: () => onClickUrl?.call(text),
            );
          },
        ),
      ],
      style: AppStyles.s15W400.copyWith(
        color: context.customColor.textColor,
        height: 1.4,
      ),
    );
  }

  TextSpan _buildTextSpan({
    required String text,
    required TextStyle? textStyle,
    required VoidCallback? onClick,
    Color color = AppColors.blue,
  }) {
    return TextSpan(
      text: text,
      style: textStyle?.copyWith(color: color, decorationColor: AppColors.blue),
      recognizer: TapGestureRecognizer()..onTap = onClick,
    );
  }
}
