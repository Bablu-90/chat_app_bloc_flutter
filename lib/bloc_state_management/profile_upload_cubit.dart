import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUploadCubit extends Cubit<File>{
  final picker = ImagePicker();
  ProfileUploadCubit():super(File(''));

  Future<void> takeImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality: 50);
    if(pickedFile != null){
      emit(File(pickedFile.path));
    }
  }


}