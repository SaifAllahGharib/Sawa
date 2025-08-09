class VideoPlayerState {
  final bool showControls;
  final bool isPlaying;
  final bool isInitialized;
  final bool sound;

  const VideoPlayerState({
    this.showControls = true,
    this.isPlaying = false,
    this.isInitialized = false,
    this.sound = true,
  });

  VideoPlayerState copyWith({
    bool? showControls,
    bool? isPlaying,
    bool? isInitialized,
    bool? sound,
  }) {
    return VideoPlayerState(
      showControls: showControls ?? this.showControls,
      isPlaying: isPlaying ?? this.isPlaying,
      isInitialized: isInitialized ?? this.isInitialized,
      sound: sound ?? this.sound,
    );
  }
}
