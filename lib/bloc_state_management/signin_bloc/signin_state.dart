class SigninState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isPhoneNumber;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  SigninState(
      {required this.isEmailValid,
      required this.isPasswordValid,
      required this.isSubmitting,
        required this.isPhoneNumber,
      required this.isSuccess,
      required this.isFailure});

  factory SigninState.initial() {
    return SigninState(
        isEmailValid: true,
        isPasswordValid: true,
        isPhoneNumber : true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory SigninState.loading() {
    return SigninState(
        isEmailValid: true,
        isPasswordValid: true,
        isPhoneNumber : true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }
  factory SigninState.failure() {
    return SigninState(
        isEmailValid: true,
        isPasswordValid: true,
        isPhoneNumber:true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory SigninState.success() {
    return SigninState(
        isEmailValid: true,
        isPasswordValid: true,
        isPhoneNumber: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  SigninState update({
    required bool isEmailValid,
    required bool isPasswordValid,
    required bool isPhoneNumberValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SigninState copyWith({
    required bool isEmailValid,
    required bool isPasswordValid,
    required bool isPhoneNumberValid,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return SigninState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isPhoneNumber: isPhoneNumberValid?? this.isPhoneNumber,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }
}
