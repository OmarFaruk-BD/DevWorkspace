class AppValidator {
  /// Validates if the provided [email] is in a valid email format.
  bool emailValidator(String? email) {
    if (email == null || email.isEmpty) return false;
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)*$')
        .hasMatch(email);
  }

  /// Checks if the provided [str] is a valid link.
  bool isLink(String? str) {
    if (str == null || str.isEmpty) return false;
    return RegExp(
            r'^(https?:\/\/)?([\w\d_-]+)\.([\w\d_\.-]+)\/?\??([^#\n\r]*)?#?([^\n\r]*)$')
        .hasMatch(str);
  }

  /// Validates if the provided [phoneNumber] matches a common phone number format.
  bool phoneValidator(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) return false;
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phoneNumber);
  }

  /// Checks if the provided [password] is strong enough.
  /// Criteria: At least 8 characters, includes a number, a letter, and a special character.
  bool passwordValidator(String? password) {
    if (password == null || password.isEmpty) return false;
    return RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password);
  }

  /// Validates if the provided [name] is a valid name.
  /// Criteria: Only letters and spaces, at least 2 characters.
  bool nameValidator(String? name) {
    if (name == null || name.isEmpty) return false;
    return RegExp(r'^[a-zA-Z\s]{2,}$').hasMatch(name);
  }

  /// Validates if the provided [number] is a numeric value.
  bool isNumeric(String? number) {
    if (number == null || number.isEmpty) return false;
    return RegExp(r'^-?[0-9]+$').hasMatch(number);
  }

  /// Validates if the provided [text] matches a given [pattern].
  bool customValidator(String? text, String pattern) {
    if (text == null || text.isEmpty) return false;
    return RegExp(pattern).hasMatch(text);
  }
}
