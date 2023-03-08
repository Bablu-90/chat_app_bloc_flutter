
import 'dart:io';

import 'package:chat_app_bloc_flutter/models/user_model.dart';
import 'package:chat_app_bloc_flutter/services/user_service.dart';
import 'package:chat_app_bloc_flutter/utils/profile_upload.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserService userService;
  final ProfileUpload imageUpload;
  OnboardingCubit(this.userService,this.imageUpload) : super(OnboardingInitial());

 Future<void> connect(String name, File profileImage) async {
    emit(OnboardingLoading());
    try {
      final user = await userService.connect(UserModel(name: name, id: '', lastSeen: DateTime.now(), email: '', active: true));
      
      final updatedUser =
      await userService.connect(user);
      emit(OnboardingSuccess(updatedUser));
    } catch (e) {
      emit(OnboardingInitial());
    }
  }
}


