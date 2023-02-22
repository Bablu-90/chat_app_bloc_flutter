
import 'package:chat_app_Cubit_flutter/Cubit_state_management/auth_Cubit/auth_event.dart';
import 'package:chat_app_Cubit_flutter/Cubit_state_management/auth_Cubit/auth_state.dart';
import 'package:chat_app_Cubit_flutter/locator.dart';
import 'package:chat_app_Cubit_flutter/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_Cubit/flutter_Cubit.dart';
import 'dart:async';


class AuthBloc extends Cubit<AuthState>{
  final AuthService authService = locator<AuthService>();
  AuthCubit(): super(AuthInitial());


  @override
  Stream<AuthState>mapEventToState(AuthEvent event) async*{
    if (event is AuthStarted){
      yield* mapAuthenticationStartedToState();
    }else if(event is AuthLoggedIn){
      yield* mapAuthenticationLoggedInToState();
    }else if(event is AuthLoggedOut){
      yield* mapAuthenticationLoggedOutInToState();
    }
  }


  Stream<AuthState> mapAuthenticationLoggedOutInToState()async*{
    yield AuthFailure();
    authService.signOut();
  }

  Stream<AuthState>mapAuthenticationLoggedInToState()async*{
    yield AuthSuccess(userModel: await authService.getUser());
  }

  Stream<AuthState> mapAuthenticationStartedToState()async*{
    final isSignedIn = await authService.isSignedIn();
    if(isSignedIn){
      final user = await authService.getUser();
      yield AuthSuccess(userModel: user);
    }else{
      yield AuthFailure();
    }
  }

}