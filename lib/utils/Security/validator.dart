class Validator {

    static isEmptyValid(String value) {
if (value.isEmpty) return 'Введите название';
return null;
  }
    static isNameValid(String value) {
    if (value.length<3) return 'Введите имя (не менее 3х знаков)';
    return null;
  }
    static isPhoneValid(String value) {
if (value.isEmpty) return 'Введите номер телефона';
if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)){
      return 'Введите корректный номер (через 8)';
}
return null;
  }
  
    static isEmailValid(String value) {
    if (value.isEmpty) return 'Введите Email';
    if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
                return 'Введите действительный Email';
    }
    return null;
  }
}
