import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'video_player_state.dart';

@injectable
class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(const VideoPlayerState());

  void setIsInitialized(bool value) =>
      emit(state.copyWith(isInitialized: value));

  void setShowControls(bool value) => emit(state.copyWith(showControls: value));

  void toggleControls() =>
      emit(state.copyWith(showControls: !state.showControls));

  void setIsPlaying(bool value) => emit(state.copyWith(isPlaying: value));
}
