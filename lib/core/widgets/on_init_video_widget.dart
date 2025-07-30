import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:video_player/video_player.dart';

import '../shared/cubits/video_player/video_player_cubit.dart';
import '../shared/cubits/video_player/video_player_state.dart';
import '../utils/enums.dart';
import 'app_gesture_detector_button.dart';
import 'app_loading_widget.dart';
import 'app_padding_widget.dart';
import 'play_pause_icon_widget.dart';

class OnInitVideoWidget extends StatefulWidget {
  final String path;
  final VideoType videoType;

  const OnInitVideoWidget({
    super.key,
    required this.path,
    required this.videoType,
  });

  @override
  State<OnInitVideoWidget> createState() => _OnInitVideoWidgetState();
}

class _OnInitVideoWidgetState extends State<OnInitVideoWidget> {
  late final VideoPlayerController _controller;
  late final ValueNotifier<double> _sliderProgress;
  bool _wasPlaying = false;
  Timer? _progressUpdater;
  Timer? _showHideVideoControllers;

  @override
  void initState() {
    super.initState();

    if (widget.videoType == VideoType.file) {
      _controller = VideoPlayerController.file(File(widget.path));
    } else {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path));
    }

    _sliderProgress = ValueNotifier(0);

    _controller.initialize().then((_) {
      if (mounted) {
        context.read<VideoPlayerCubit>().setIsInitialized(
          _controller.value.isInitialized,
        );
        context.read<VideoPlayerCubit>().setIsPlaying(
          _controller.value.isPlaying,
        );
        _startProgressUpdates();
        _controller.addListener(_handleVideoStateChanged);
      }
    });
  }

  @override
  void dispose() {
    _progressUpdater?.cancel();
    _showHideVideoControllers?.cancel();
    _sliderProgress.dispose();
    _controller.removeListener(_handleVideoStateChanged);
    _controller.dispose();
    super.dispose();
  }

  void _startProgressUpdates() {
    _progressUpdater = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (_controller.value.isInitialized &&
          _controller.value.duration.inMilliseconds > 0) {
        final position = _controller.value.position.inMilliseconds.toDouble();
        final duration = _controller.value.duration.inMilliseconds.toDouble();
        final percent = (position / duration) * 100;
        _sliderProgress.value = percent.clamp(0.0, 100.0);
      }
    });
  }

  void _handleVideoStateChanged() {
    if (!mounted || !_controller.value.isInitialized) return;

    final videoCubit = context.read<VideoPlayerCubit>();
    final isPlaying = _controller.value.isPlaying;

    videoCubit.setIsPlaying(isPlaying);

    if (_controller.value.isCompleted) {
      _showHideVideoControllers?.cancel();
      videoCubit.setShowControls(true);
      return;
    }

    if (isPlaying && !_wasPlaying) {
      _restartHideControlsTimer();
    }

    _wasPlaying = isPlaying;
  }

  void _restartHideControlsTimer() {
    final videoCubit = context.read<VideoPlayerCubit>();

    _showHideVideoControllers?.cancel();
    _showHideVideoControllers = Timer(const Duration(milliseconds: 1500), () {
      if (videoCubit.state.isPlaying && videoCubit.state.showControls) {
        videoCubit.setShowControls(false);
      }
    });
  }

  void _toggleControls(BuildContext context) {
    final videoCubit = context.read<VideoPlayerCubit>();

    videoCubit.toggleControls();

    if (videoCubit.state.isPlaying && videoCubit.state.showControls) {
      _restartHideControlsTimer();
    } else {
      _showHideVideoControllers?.cancel();
    }
  }

  void _playPauseVideo({
    required BuildContext context,
    required VideoPlayerState state,
  }) {
    if (state.isInitialized) {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }

      context.read<VideoPlayerCubit>().setIsPlaying(
        _controller.value.isPlaying,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
            builder: (context, state) {
              if (!state.isInitialized) {
                return const AppLoadingWidget();
              }

              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    AppGestureDetectorButton(
                      onTap: () => _toggleControls(context),
                      child: VideoPlayer(_controller),
                    ),
                    if (state.showControls)
                      Column(
                        children: [
                          const Spacer(),
                          AppPaddingWidget(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildButtonSeekTo(
                                  onClick: () {},
                                  icon: Icons.replay_10_rounded,
                                ),
                                20.horizontalSpace,
                                AppGestureDetectorButton(
                                  onTap: () => _playPauseVideo(
                                    context: context,
                                    state: state,
                                  ),
                                  child: PlayPauseIconWidget(
                                    isPlay: state.isPlaying,
                                  ),
                                ),
                                20.horizontalSpace,
                                _buildButtonSeekTo(
                                  onClick: () {},
                                  icon: Icons.forward_10_rounded,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          _buildSeekBar(context: context, state: state),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        AppPaddingWidget(
          child: Column(
            children: [
              AppGestureDetectorButton(
                onTap: () => context.navigator.pop(),
                child: Icon(
                  Icons.close,
                  size: 25.r,
                  color: context.customColor.icon,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonSeekTo({
    required VoidCallback onClick,
    required IconData icon,
  }) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000.r),
          color: Colors.black.withValues(alpha: 0.3),
        ),
        child: Icon(icon, size: 35.r, color: Colors.white),
      ),
    );
  }

  Widget _buildSeekBar({
    required BuildContext context,
    required VideoPlayerState state,
  }) {
    return ValueListenableBuilder<double>(
      valueListenable: _sliderProgress,
      builder: (context, value, _) {
        return Slider(
          value: value,
          min: 0,
          max: 100,
          onChanged: (newValue) {
            final newPosition = Duration(
              milliseconds:
                  (_controller.value.duration.inMilliseconds * (newValue / 100))
                      .round(),
            );
            _controller.seekTo(newPosition);
            _sliderProgress.value = newValue;
          },
        );
      },
    );
  }
}
