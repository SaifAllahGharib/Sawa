import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/post_entity.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/extensions/number_extensions.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/post_gallery_view_widget.dart';
import '../styles/app_styles.dart';

class MiddleSectionPostCard extends StatelessWidget {
  final String? content;
  final PostEntity post;

  const MiddleSectionPostCard({
    super.key,
    required this.content,
    required this.post,
  });

  TextDirection _detectTextDirection(String text) {
    final arabicCount = RegExp(r'[\u0600-\u06FF]').allMatches(text).length;
    final latinCount = RegExp(r'[A-Za-z]').allMatches(text).length;
    return arabicCount > latinCount ? TextDirection.rtl : TextDirection.ltr;
  }

  void _copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    HapticFeedback.vibrate();
  }

  void _onTapInUrl(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.tr.open),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                _copyText(url);
                Navigator.pop(context);
              },
              child: Text(context.tr.copy),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (content != null && content!.isNotEmpty)
          AppPaddingWidget(
            top: 0,
            bottom: 12.r,
            child: SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onLongPress: () => _copyText(content.toString()),
                child: ReadMoreText(
                  content.toString(),
                  textAlign: TextAlign.start,
                  textDirection: _detectTextDirection(content!),
                  trimMode: TrimMode.Line,
                  trimLines: 10,
                  trimExpandedText: '\u00A0${context.tr.showLess}',
                  trimCollapsedText: '\u00A0${context.tr.showMore}',
                  moreStyle: AppStyles.s14W400.copyWith(color: Colors.blue),
                  lessStyle: AppStyles.s14W400.copyWith(color: Colors.blue),
                  annotations: [
                    Annotation(
                      regExp: RegExp(
                        r'#([\u0600-\u06FF\u0750-\u077Fa-zA-Z0-9_]+)',
                        unicode: true,
                      ),
                      spanBuilder:
                          ({required String text, TextStyle? textStyle}) =>
                              TextSpan(
                                text: text,
                                style: textStyle?.copyWith(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    debugPrint('Hashtag tapped: $text');
                                  },
                              ),
                    ),
                    Annotation(
                      regExp: RegExp(r'<@(\d+)>'),
                      spanBuilder:
                          ({required String text, TextStyle? textStyle}) =>
                              TextSpan(
                                text: 'User$text',
                                style: textStyle?.copyWith(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    debugPrint('Mention tapped: $text');
                                  },
                              ),
                    ),
                    Annotation(
                      regExp: RegExp(
                        r'(?:(?:https?|ftp)://)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
                      ),
                      spanBuilder:
                          ({required String text, TextStyle? textStyle}) =>
                              TextSpan(
                                text: text,
                                style: textStyle?.copyWith(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async =>
                                      _onTapInUrl(context, text),
                              ),
                    ),
                  ],
                  style: AppStyles.s15W400.copyWith(
                    color: context.customColor.textColor,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
        if (post.media.isNotEmpty) PostGalleryViewWidget(post: post),
      ],
    );
  }
}
