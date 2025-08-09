import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_colors.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_placeholder.dart';
import 'package:video_player/video_player.dart';

import '../shared/cubits/video_player/video_player_cubit.dart';
import '../shared/cubits/video_player/video_player_state.dart';
import '../utils/enums.dart';
import 'app_gesture_detector_button.dart';
import 'app_padding_widget.dart';
import 'play_pause_icon_widget.dart';

class InitVideoWidget extends StatefulWidget {
  final String path;
  final VideoType videoType;
  final bool showTopSec;

  const InitVideoWidget({
    super.key,
    required this.path,
    required this.videoType,
    required this.showTopSec,
  });

  @override
  State<InitVideoWidget> createState() => _InitVideoWidgetState();
}

class _InitVideoWidgetState extends State<InitVideoWidget> {
  late final VideoPlayerController _videoPlayerController;
  late final ValueNotifier<double> _sliderProgress;
  late final ValueNotifier<int> _timeController;
  bool _wasPlaying = false;
  bool _isUserInteracting = false;
  double? _lastSeekValue;
  Timer? _showHideVideoControllers;

  @override
  void initState() {
    _initControllers();

    super.initState();
  }

  @override
  void dispose() {
    _showHideVideoControllers?.cancel();
    _sliderProgress.dispose();
    _videoPlayerController.removeListener(_videoControllerListener);
    _videoPlayerController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _initControllers() {
    if (widget.videoType == VideoType.file) {
      _videoPlayerController = VideoPlayerController.file(File(widget.path));
    } else {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.path),
      );
    }

    _videoPlayerController.initialize().then((_) => _afterInitControllers());

    _sliderProgress = ValueNotifier(0);
    _timeController = ValueNotifier(0);
  }

  void _afterInitControllers() {
    if (mounted) {
      context.read<VideoPlayerCubit>().setIsInitialized(_videoPlayerController);
      context.read<VideoPlayerCubit>().setIsPlaying(_videoPlayerController);
      _videoPlayerController.addListener(_videoControllerListener);
    }
  }

  void _videoControllerListener() {
    _handleVideoTime();
    _startProgressUpdates();
    _handleVideoStateChanged();
  }

  void _startProgressUpdates() {
    if (!_isUserInteracting &&
        _videoPlayerController.value.isInitialized &&
        _videoPlayerController.value.duration.inMilliseconds > 0) {
      final position = _videoPlayerController.value.position.inMilliseconds
          .toDouble();
      final duration = _videoPlayerController.value.duration.inMilliseconds
          .toDouble();
      final percent = (position / duration) * 100;
      _sliderProgress.value = percent.clamp(0, 100);
    }
  }

  void _handleVideoStateChanged() {
    if (!mounted || !_videoPlayerController.value.isInitialized) return;

    final videoCubit = context.read<VideoPlayerCubit>();
    final isPlaying = _videoPlayerController.value.isPlaying;

    videoCubit.setIsPlaying(_videoPlayerController);

    if (_videoPlayerController.value.isCompleted) {
      _showHideVideoControllers?.cancel();
      videoCubit.setShowControls(true);
      return;
    }

    if (isPlaying && !_wasPlaying) {
      _restartHideControlsTimer();
    }

    _wasPlaying = isPlaying;
  }

  void _handleVideoTime() {
    _timeController.value = _videoPlayerController.value.position.inSeconds;
  }

  void _restartHideControlsTimer() {
    final videoCubit = context.read<VideoPlayerCubit>();

    _showHideVideoControllers?.cancel();
    _showHideVideoControllers = Timer(const Duration(milliseconds: 2100), () {
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

  void _playVideo(BuildContext context) {
    context.read<VideoPlayerCubit>().play(_videoPlayerController);
  }

  void _pauseVideo(BuildContext context) {
    context.read<VideoPlayerCubit>().pause(_videoPlayerController);
  }

  void _handleClickPlayPause(BuildContext context, VideoPlayerState state) {
    if (state.isPlaying) {
      _pauseVideo(context);
    } else {
      _playVideo(context);
    }
  }

  void _onSound(BuildContext context) {
    context.read<VideoPlayerCubit>().onSound(_videoPlayerController);
  }

  void _offSound(BuildContext context) {
    context.read<VideoPlayerCubit>().offSound(_videoPlayerController);
  }

  void _handleClickOnOffSound(BuildContext context, VideoPlayerState state) {
    if (state.sound) {
      _offSound(context);
    } else {
      _onSound(context);
    }
  }

  void _seekBackward() {
    context.read<VideoPlayerCubit>().seekBackward(_videoPlayerController);
  }

  void _seekForward() {
    context.read<VideoPlayerCubit>().seekForward(_videoPlayerController);
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
                return AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: const AppPlaceholder(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                );
              }

              return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Stack(
                  children: [
                    AppGestureDetectorButton(
                      onTap: () => _toggleControls(context),
                      child: VideoPlayer(_videoPlayerController),
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
                                  onClick: _seekBackward,
                                  icon: Icons.replay_5_rounded,
                                ),
                                20.horizontalSpace,
                                AppGestureDetectorButton(
                                  onTap: () =>
                                      _handleClickPlayPause(context, state),
                                  child: PlayPauseIconWidget(
                                    isPlay: state.isPlaying,
                                  ),
                                ),
                                20.horizontalSpace,
                                _buildButtonSeekTo(
                                  onClick: _seekForward,
                                  icon: Icons.forward_5_rounded,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppPaddingWidget(
                                bottom: 0,
                                child: _buildVideoDurationAndVolume(state),
                              ),
                              _buildSeekBar(context: context, state: state),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        if (widget.showTopSec)
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

  Widget _buildVideoDurationAndVolume(VideoPlayerState state) {
    final duration = _videoPlayerController.value.duration;
    final int hours = duration.inHours;
    final int minute = duration.inMinutes - (hours * 60);
    final int secondes = duration.inSeconds - (minute * 60);
    String videoIsSorMorH = 's';

    final String fH = hours.toString().padLeft(2, '0');
    final String fM = minute.toString().padLeft(2, '0');
    final String fS = secondes.toString().padLeft(2, '0');

    String time = '00:00:00';

    if (hours > 0) {
      time = '$fH:$fM:$fS';
      videoIsSorMorH = 'h';
    } else if (minute > 0) {
      time = '$fM:$fS';
      videoIsSorMorH = 'm';
    } else if (secondes > 0) {
      time = fS;
      videoIsSorMorH = 's';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.r, horizontal: 8.r),
          decoration: BoxDecoration(
            color: AppColors.gray.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Text(
                '$time / ',
                style: AppStyles.s15WB.copyWith(color: Colors.white),
              ),
              ValueListenableBuilder(
                valueListenable: _timeController,
                builder: (context, value, child) {
                  final int totalSeconds = value.toInt();
                  final int h = totalSeconds ~/ 3600;
                  final int m = (totalSeconds % 3600) ~/ 60;
                  final int s = totalSeconds % 60;

                  final String fH = h.toString().padLeft(2, '0');
                  final String fM = m.toString().padLeft(2, '0');
                  final String fS = s.toString().padLeft(2, '0');

                  String time = '00:00:00';

                  switch (videoIsSorMorH) {
                    case 'h':
                      time = '$fH:$fM:$fS';
                      break;
                    case 'm':
                      time = '$fM:$fS';
                      break;
                    case 's':
                      time = fS;
                      break;
                  }

                  return Text(
                    time,
                    style: AppStyles.s15WB.copyWith(color: Colors.white),
                  );
                },
              ),
            ],
          ),
        ),
        AppGestureDetectorButton(
          onTap: () => _handleClickOnOffSound(context, state),
          child: Container(
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              color: AppColors.gray.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(1000.r),
            ),
            child: Icon(
              state.sound ? Icons.volume_up_rounded : Icons.volume_off_outlined,
              size: 26.r,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonSeekTo({
    required VoidCallback onClick,
    required IconData icon,
  }) {
    return AppGestureDetectorButton(
      onTap: onClick,
      child: Align(
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
          onChangeStart: (_) {
            _isUserInteracting = true;
          },
          onChanged: (newValue) {
            _sliderProgress.value = newValue;
            if (_lastSeekValue == null ||
                (newValue - _lastSeekValue!).abs() > 0.5) {
              final newPosition = Duration(
                milliseconds:
                    (_videoPlayerController.value.duration.inMilliseconds *
                            (newValue / 100))
                        .round(),
              );
              _videoPlayerController.seekTo(newPosition);
              _lastSeekValue = newValue;
            }
          },
          onChangeEnd: (newValue) {
            final newPosition = Duration(
              milliseconds:
                  (_videoPlayerController.value.duration.inMilliseconds *
                          (newValue / 100))
                      .round(),
            );
            _videoPlayerController.seekTo(newPosition);
            _isUserInteracting = false;
            _lastSeekValue = null;
          },
        );
      },
    );
  }
}
