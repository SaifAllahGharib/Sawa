class AppRegExp {
  const AppRegExp._();

  static bool emailValidator(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    return emailRegex.hasMatch(email);
  }

  static bool phoneValidator(String phone) {
    final phoneRegex = RegExp(r'^\d{11}$');
    return phoneRegex.hasMatch(phone);
  }

  static bool passwordValidator(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  static RegExp get url =>
      RegExp(r'(?:(?:https?|ftp)://)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

  static RegExp get mention => RegExp(r'<@(\d+)>');

  static RegExp get hashtags =>
      RegExp(r'#([\u0600-\u06FF\u0750-\u077Fa-zA-Z0-9_]+)', unicode: true);
}
