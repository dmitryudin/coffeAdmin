class Validator {
  bool isSecurityValid(value) {
    // TODO Реализовать метод
    return true;
  }

  static isEmptyValid(String value) {
    if (value.isEmpty) return 'Пожалуста, введите данные';
    return null;
  }

  static isEmailValid(String value) {
    // TODO Реализовать метод
    return '';
  }

  static isPasswordValid(String value) {
    // TODO Реализовать метод
    return '';
  }

  static isPhoneValid(String value) {
    // TODO Реализовать метод
    return '';
  }
}
