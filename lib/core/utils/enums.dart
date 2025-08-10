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

enum ReactionType {
  like,
  love,
  haha,
  wow,
  sad,
  angry;

  String toValue() {
    switch (this) {
      case ReactionType.like:
        return 'like';
      case ReactionType.love:
        return 'love';
      case ReactionType.haha:
        return 'haha';
      case ReactionType.wow:
        return 'wow';
      case ReactionType.sad:
        return 'sad';
      case ReactionType.angry:
        return 'angry';
    }
  }

  static ReactionType fromValue(String value) {
    return ReactionType.values.firstWhere(
      (type) => type.toValue() == value,
      orElse: () => ReactionType.like,
    );
  }
}
