
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_event.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_state.dart';
import 'package:chat_app_bloc_flutter/locator.dart';
import 'package:chat_app_bloc_flutter/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthService authService = locator<AuthService>();
  SigninBloc() : super(SigninState.initial());

  @override
  Stream<SigninState?> mapEventToState(SigninEvent event) async* {
    if (event is SigninEmailChange) {
      yield* _mapSigninEmailChangeToState(event.email);
    } else if (event is SigninPasswordChanged) {
      yield* _mapSigninPasswordChangeToState(event.password);
    } else if (event is SigninWithCredentialsPress) {
      yield* _mapSigninWithCredentialsPressToState(
          email: event.email, password: event.password,phoneNumber: event.phoneNumber);
    }
  }
}

Stream<SigninState?> _mapSigninEmailChangeToState(String email) async* {
  yield state.update(isEmailValid:Validators.isValidEmail(email));
}

Stream<SigninState?> _mapSigninPasswordChangeToState(String password) async* {
  yield state.update(isPasswordValid: Validators.isValidPassword(password));
}

Stream<SigninState> _mapSigninWithCredentialsPressToState(
    {required String email, required String password, required String phoneNumber}) async* {
  yield SigninState.loading();
  try {
    await
    AuthService.signUp(email, password, phoneNumber);
    yield SigninState.success();
  } catch (_) {
    yield SigninState.failure();
  }
}
