import 'dart:io';

import 'package:chat_app_bloc_flutter/bloc_state_management/profile_upload_cubit.dart';
import 'package:chat_app_bloc_flutter/color.dart';
import 'package:chat_app_bloc_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpload extends StatefulWidget {
  const ProfileUpload({Key? key}) : super(key: key);

  @override
  State<ProfileUpload> createState() => _ProfileUploadState();
}

class _ProfileUploadState extends State<ProfileUpload> {
  File? StoredImage;

  Future<void> takeImage() async {
    ImagePicker imagePicker = ImagePicker();
    await imagePicker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        setState(() {
          StoredImage = File(value.path);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      width: 126,
      child: Material(
        color: isLightTheme(context) ? Color(0xFFF2F2F2) : Colors.black,
        borderRadius: BorderRadius.circular(126.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            StoredImage == null
                ? CircleAvatar(child: BlocBuilder<ProfileUploadCubit, File>(
                        builder: (context, state) {
                    return state.path == ''
                        ? Icon(
                            Icons.person_outline_outlined,
                            size: 110.0,
                            color: isLightTheme(context)
                                ? kIconLight
                                : Colors.black,
                          )
                        : Image.file(
                            state,
                            fit: BoxFit.fill,
                          );
                  })
                    /*Icon(
                Icons.person_outline_outlined,
                size: 110.0,
                color: isLightTheme(context) ? kIconLight : Colors.black,
              ),*/
                    )
                : Image.file(
                    StoredImage!,
                    fit: BoxFit.fill,
                  ),
            Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () async {
                    await context.read<ProfileUploadCubit>().takeImage();
                  },
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: kPrimaryColor,
                    size: 38.0,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
