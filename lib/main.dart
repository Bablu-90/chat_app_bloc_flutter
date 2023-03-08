


import 'package:chat_app_bloc_flutter/bloc_state_management/profile_upload_cubit.dart';
import 'package:chat_app_bloc_flutter/presentations/ui/screens/onboarding_screen.dart';

import 'package:chat_app_bloc_flutter/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat App',
        theme:lightTheme(context),
        darkTheme: darkTheme(context),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => ProfileUploadCubit(),
          child: OnBoardingScreen(),
        )
    );
  }
}
