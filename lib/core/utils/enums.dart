enum UserInfo {
  id('id'),
  name('name'),
  email('email'),
  image('image'),
  bio('bio');

  final String _value;

  const UserInfo(this._value);

  String get asString => _value;
}

enum TextFormType { password, text }

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

enum ProfileUpdateType { none, image, name, bio, deletePost }
