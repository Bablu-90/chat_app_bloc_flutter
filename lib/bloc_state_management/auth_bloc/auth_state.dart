



import 'package:chat_app_bloc_flutter/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

 class AuthState extends Equatable{
  @override
  List<Object>get props => [];
}

class AuthInitial extends AuthState{

}

class AuthSuccess extends AuthState{
  final UserModel userModel;

  AuthSuccess({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class AuthFailure extends AuthState{}