



import 'package:chat_app_bloc_flutter/constants.dart';
import 'package:flutter/material.dart';

import '../buttons/primary_button.dart';
import 'chat_screen.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(children: [
          Spacer(flex: 2),
          Image.asset(
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? "assets/icons/chat light.png.png"
                  : "assets/icons/chat dark.png.png",
              height: 146),
          Spacer(),
          TextField(
            decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: kPrimaryColor,
                ),
                hintText: "Email"),
          ),
          SizedBox(height: 30),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ),
                hintText: "Password"),
          ),
          SizedBox(height: 30),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ),
                hintText: "Confirm password"),
          ),
          Spacer(),
          PrimaryButton(
            text: "Register",
            color: Theme.of(context).colorScheme.secondary,
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontSize: 12,
                    )),
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding * 1.5),
          Spacer(flex: 2)
        ]),
      ),
    ));
  }
}
