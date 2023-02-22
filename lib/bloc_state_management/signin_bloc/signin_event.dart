import 'package:equatable/equatable.dart';

class SigninEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SigninEmailChange extends SigninEvent {
  final String email;

  SigninEmailChange({required this.email});

  @override
  List<Object> get props => [email];
}

class SigninPasswordChanged extends SigninEvent {
  final String password;

  SigninPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}
class SigninPhoneNumberChange extends SigninEvent{
  final String phoneNumber;
  SigninPhoneNumberChange({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class SigninWithCredentialsPress extends SigninEvent {
  final String email;
  final String password;
  final String phoneNumber;

  SigninWithCredentialsPress({required this.email, required this.password,required this.phoneNumber});

  @override
  List<Object> get props => [email, password,phoneNumber];
}
