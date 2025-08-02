enum AuthStatus { authenticated, unauthenticated, error }

enum MediaType {
  image('Image'),
  video('Video'),
  media('Media'),
  unknown('Unknown');

  final String _value;

  const MediaType(this._value);

  @override
  String toString() => _value;
}

enum VideoType { file, network }
