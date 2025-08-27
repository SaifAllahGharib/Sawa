import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sawa/core/widgets/app_read_more_text.dart';
import 'package:sawa/features/home/domain/entities/post_entity.dart';

import '../../../../core/extensions/number_extensions.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/post_gallery_view_widget.dart';
import '../services/url_launcher/url_launcher_service.dart';
import 'url_alert_dialog_widget.dart';

class MiddleSectionPostCard extends StatelessWidget {
  final String? content;
  final PostEntity post;

  const MiddleSectionPostCard({
    super.key,
    required this.content,
    required this.post,
  });

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
                child: AppReadMoreText(
                  content: content ?? '',
                  onClickUrl: (url) => _onTapInUrl(context, url),
                ),
              ),
            ),
          ),
        if (post.media.isNotEmpty) PostGalleryViewWidget(post: post),
      ],
    );
  }
}
