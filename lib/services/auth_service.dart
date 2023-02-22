
import 'package:chat_app_bloc_flutter/locator.dart';
import 'package:chat_app_bloc_flutter/services/repository_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;
  final RepositoryService repositoryService = locator<RepositoryService>();

  AuthService() : firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithCredentials(String phoneNumber, String email,String password ) {
    return firebaseAuth.signInWithPhoneNumber(phoneNumber);

  }

  Future<bool> isSignedIn() async {
    final currentUser = await firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?>signUp(String phoneNumber, String password, String email)async{
    return await firebaseAuth.currentUser!;
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([firebaseAuth.signOut()]);
  }

  Future<UserModel> getUser() async {
    final firebaseUser = await firebaseAuth.currentUser;
    print(firebaseUser!.uid);
    UserModel? usermodel = await repositoryService.getUser(firebaseUser.uid);

    if (usermodel == null) {
      usermodel = UserModel(
        id: firebaseUser.uid,
        lastSeen: usermodel!.lastSeen,
        email: usermodel!.email,
        name: usermodel!.name,
        profilePicLink: usermodel!.profilePicLink,
      );
      repositoryService.registerUser(usermodel);
    }

    return usermodel;
  }
}
