bool emailValidator(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  return emailRegex.hasMatch(email);
}

bool phoneValidator(String phone) {
  final phoneRegex = RegExp(r"^\d{11}$");
  return phoneRegex.hasMatch(phone);
}
