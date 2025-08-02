import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_file_image.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_loading_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../utils/enums.dart';
import 'play_pause_icon_widget.dart';

class AppVideoPreview extends StatefulWidget {
  final String path;
  final VideoType videoType;

  const AppVideoPreview({
    super.key,
    required this.path,
    required this.videoType,
  });

  @override
  State<AppVideoPreview> createState() => _AppVideoPreviewState();
}

class _AppVideoPreviewState extends State<AppVideoPreview>
    with AutomaticKeepAliveClientMixin {
  String? _thumbnailFile;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    generateVideoThumbnail();
    super.initState();
  }

  @override
  void dispose() {
    _thumbnailFile = null;
    super.dispose();
  }

  void generateVideoThumbnail() async {
    try {
      _thumbnailFile = await VideoThumbnail.thumbnailFile(
        video: widget.path,
        quality: 75,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
      );

      setState(() {});
    } catch (e) {
      debugPrint('Thumbnail generation error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _thumbnailFile != null
        ? SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                AppFileImage(
                  image: _thumbnailFile!,
                  height: double.infinity,
                  borderRadius: BorderRadius.zero,
                ),
                const PlayPauseIconWidget(),
              ],
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: 300.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: Offset(0, 4.r),
                  ),
                ],
              ),
              child: const AppLoadingWidget(),
            ),
          );
  }
}
