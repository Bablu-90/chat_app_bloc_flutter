import 'package:chat_app_bloc_flutter/color.dart';
import 'package:chat_app_bloc_flutter/theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function(String val)? onChanged;
  final double height;
  final TextInputAction inputAction;
  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.onChanged,
      this.height = 54.0,
      required this.inputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
          keyboardType: TextInputType.text,
          onChanged: onChanged,
          textInputAction: inputAction,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            hintText: hint,
            border: InputBorder.none,
          )),
      decoration: BoxDecoration(
        color: isLightTheme(context) ? Colors.white : kBubbleDark,
        borderRadius: BorderRadius.circular(45.0),
        border: Border.all(
            color: isLightTheme(context) ? Colors.white : Color(0xFF393737),
            width: 1.5),
      ),
    );
  }
}
