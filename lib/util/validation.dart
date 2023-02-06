class Validation {
  bool isCorrect = false;

  static String? emailValidator(String? input) {
    if (input == null || input.trim().isEmpty == true) {
      return 'Can\'t be empty';
    }

    const pattern =
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    return !RegExp(pattern).hasMatch(input)
        ? 'Invail email'
        : null;
  }

  static String? passwordValidator(String? input) {
    if (input == null || input.trim().isEmpty == true) {
      return 'Can\'t be empty';
    }

    const pattern = r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$";
    return !RegExp(pattern).hasMatch(input)
        ? 'Password must contain at least one number, lowercase and uppercase letter. At least 8 characters'
        : null;
  }

  static String? secondPasswordValidator(String? pass1, String? pass2) {
    if (pass2 != pass1) {
      return 'Passwords don\'t match';
    } else {
      return null;
    }
  }

  static String? notEmptyText(String? input) {
    if (input == null || input.trim().isEmpty == true) {
      return 'Can\'t be empty';
    } else {
      return null;
    }
  }
}
