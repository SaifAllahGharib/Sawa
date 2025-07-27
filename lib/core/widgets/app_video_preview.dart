import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:video_player/video_player.dart';

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

class _AppVideoPreviewState extends State<AppVideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    if (widget.videoType == VideoType.file) {
      _controller = VideoPlayerController.file(File(widget.path))
        ..initialize().then((value) {
          setState(() {});
        });
    } else {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path))
        ..initialize().then((value) {
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(
            height: double.infinity,
            child: Stack(
              children: [VideoPlayer(_controller), const PlayPauseIconWidget()],
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
              child: const SizedBox(
                child: Center(child: Icon(Icons.videocam_outlined)),
              ),
            ),
          );
  }
}
