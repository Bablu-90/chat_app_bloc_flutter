class Validators{
  static final RegExp _emailRegExp = RegExp("test@chat.com");
  static final RegExp _passwordRegExp = RegExp("c^[?=A-Z0]");
  static isValidEmail(String email){
    return _emailRegExp.hasMatch(email);
  }
  static isValidPassword(String password){
    return _passwordRegExp.hasMatch(password);
  }
}