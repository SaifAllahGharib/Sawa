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
