import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import 'video_player_state.dart';

@injectable
class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(const VideoPlayerState());

  void setIsInitialized(VideoPlayerController videoPlayerController) => emit(
    state.copyWith(isInitialized: videoPlayerController.value.isInitialized),
  );

  void setShowControls(bool value) => emit(state.copyWith(showControls: value));

  void toggleControls() =>
      emit(state.copyWith(showControls: !state.showControls));

  void play(VideoPlayerController videoPlayerController) {
    if (state.isInitialized) {
      videoPlayerController.play();
    }
  }

  void pause(VideoPlayerController videoPlayerController) {
    if (state.isInitialized) {
      videoPlayerController.pause();
    }
  }

  void setIsPlaying(VideoPlayerController videoPlayerController) {
    emit(state.copyWith(isPlaying: videoPlayerController.value.isPlaying));
  }

  Duration _safeClamp(Duration value, Duration min, Duration max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  void seekForward(VideoPlayerController videoPlayerController) {
    final currentPosition = videoPlayerController.value.position;
    final videoDuration = videoPlayerController.value.duration;
    const skip = Duration(seconds: 10);

    final newPosition = _safeClamp(
      currentPosition + skip,
      Duration.zero,
      videoDuration,
    );

    videoPlayerController.seekTo(newPosition);
  }

  void seekBackward(VideoPlayerController videoPlayerController) {
    final currentPosition = videoPlayerController.value.position;
    const skip = Duration(seconds: 5);

    final newPosition = _safeClamp(
      currentPosition - skip,
      Duration.zero,
      videoPlayerController.value.duration,
    );

    videoPlayerController.seekTo(newPosition);
  }

  void onSound(VideoPlayerController videoPlayerController) async {
    await videoPlayerController.setVolume(1);
    emit(state.copyWith(sound: true));
  }

  void offSound(VideoPlayerController videoPlayerController) async {
    await videoPlayerController.setVolume(0);
    emit(state.copyWith(sound: false));
  }
}
