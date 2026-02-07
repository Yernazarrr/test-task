class EmailValidator {
  static bool isValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}

class CodeValidator {
  static bool isValid(String code) {
    final codeRegex = RegExp(r'^\d{6}$');
    return codeRegex.hasMatch(code);
  }
}
