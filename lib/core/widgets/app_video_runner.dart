import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_loading_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:video_player/video_player.dart';

import 'app_gesture_detector_button.dart';
import 'app_padding_widget.dart';
import 'play_pause_icon_widget.dart';

class AppVideoRunner extends StatefulWidget {
  final String path;
  final VideoType videoType;

  const AppVideoRunner({
    super.key,
    required this.path,
    required this.videoType,
  });

  @override
  State<AppVideoRunner> createState() => _AppVideoRunnerState();
}

class _AppVideoRunnerState extends State<AppVideoRunner> {
  late VideoPlayerController _controller;
  bool _showPlay = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    if (widget.videoType == VideoType.file) {
      _controller = VideoPlayerController.file(File(widget.path));
    } else {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path));
    }

    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _controller.addListener(_handleShowHidePlayPauseWidget);
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_handleShowHidePlayPauseWidget);
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _playPauseVideo() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }

    setState(() {});
  }

  void _handleShowHidePlayPauseWidget() {
    if (!mounted || !_controller.value.isInitialized) return;

    final isPlaying = _controller.value.isPlaying;

    if (isPlaying && _showPlay) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted && _controller.value.isPlaying) {
          setState(() {
            _showPlay = false;
          });
        }
      });
    } else if (!isPlaying && !_showPlay) {
      setState(() {
        _showPlay = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppGestureDetectorButton(
        onTap: _playPauseVideo,
        child: AppPaddingWidget(
          left: 0,
          right: 0,
          child: _isInitialized
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                          children: [
                            VideoPlayer(_controller),
                            if (_showPlay)
                              PlayPauseIconWidget(
                                isPlay: _controller.value.isPlaying,
                              ),
                          ],
                        ),
                      ),
                    ),
                    AppPaddingWidget(
                      child: Column(
                        children: [
                          AppGestureDetectorButton(
                            onTap: () => context.navigator.pop(),
                            child: Icon(
                              Icons.close,
                              size: 20.r,
                              color: context.customColor.icon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const AppLoadingWidget(),
        ),
      ),
    );
  }
}
