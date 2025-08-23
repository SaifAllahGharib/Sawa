import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';
import 'package:sawa/core/utils/app_reg_exp.dart';
import 'package:sawa/features/home/domain/entities/post_entity.dart';

import '../../../../core/extensions/number_extensions.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/post_gallery_view_widget.dart';
import '../services/url_launcher/url_launcher_service.dart';
import '../styles/app_styles.dart';
import 'url_alert_dialog_widget.dart';

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

  void openUrl(String url) {
    UrlLauncherService.openLink(url);
  }

  void _onTapInUrl(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => UrlAlertDialogWidget(
        onClickOpen: () => openUrl(url),
        onClickCopy: () => _copyText(url),
      ),
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
                      regExp: AppRegExp.hashtags,
                      spanBuilder: ({required text, textStyle}) {
                        return _buildTextSpan(
                          text: text,
                          textStyle: textStyle,
                          onClick: () {},
                        );
                      },
                    ),
                    Annotation(
                      regExp: AppRegExp.mention,
                      spanBuilder: ({required text, textStyle}) {
                        return _buildTextSpan(
                          text: text,
                          textStyle: textStyle,
                          onClick: () {},
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
                          onClick: () => _onTapInUrl(context, text),
                        );
                      },
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

  TextSpan _buildTextSpan({
    required String text,
    required TextStyle? textStyle,
    required VoidCallback onClick,
    Color color = AppColors.blue,
  }) {
    return TextSpan(
      text: text,
      style: textStyle?.copyWith(color: color, decorationColor: AppColors.blue),
      recognizer: TapGestureRecognizer()..onTap = onClick,
    );
  }
}
