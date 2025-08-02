class VideoPlayerState {
  final bool showControls;
  final bool isPlaying;
  final bool isInitialized;

  const VideoPlayerState({
    this.showControls = true,
    this.isPlaying = false,
    this.isInitialized = false,
  });

  VideoPlayerState copyWith({
    bool? showControls,
    bool? isPlaying,
    bool? isInitialized,
  }) {
    return VideoPlayerState(
      showControls: showControls ?? this.showControls,
      isPlaying: isPlaying ?? this.isPlaying,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}
