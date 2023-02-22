


import 'package:chat_app_bloc_flutter/constants.dart';
import 'package:chat_app_bloc_flutter/screens/verification_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Spacer(flex: 2),
          Image.asset("assets/images/welcome-user.png"),
          Spacer(flex: 3),
          Text("Welcome to Chat App",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold, fontFamily: 'Desolate-Bold')),
          Spacer(),
          Text(
            "Free to chat with anybody in your \nmother languages",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.64)),
          ),
          Spacer(flex: 3),
          FittedBox(
            child: TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerificationScreen())),
                child: Row(
                  children: [
                    Text("Skip",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.8))),
                    SizedBox(width: kDefaultPadding / 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.8),
                    )
                  ],
                )),
          )
        ]),
      ),
    );
  }
}
