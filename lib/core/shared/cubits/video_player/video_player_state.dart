class VideoPlayerState {
  final bool showControls;
  final double progress;
  final bool isPlaying;
  final bool isInitialized;

  const VideoPlayerState({
    this.showControls = true,
    this.progress = 0,
    this.isPlaying = false,
    this.isInitialized = false,
  });

  VideoPlayerState copyWith({
    bool? showControls,
    double? progress,
    bool? isPlaying,
    bool? isInitialized,
  }) {
    return VideoPlayerState(
      showControls: showControls ?? this.showControls,
      progress: progress ?? this.progress,
      isPlaying: isPlaying ?? this.isPlaying,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}
