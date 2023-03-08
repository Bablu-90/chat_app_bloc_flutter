import 'package:chat_app_bloc_flutter/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class UserService{
  UserService(DatabaseReference ref);

  Future<UserModel> connect(UserModel user);
  Future<List<UserModel>> online();
  Future<void>disconnect(UserModel user);
}