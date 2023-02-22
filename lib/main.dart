
import 'package:chat_app_bloc_flutter/bloc_state_management/auth_bloc/auth_bloc.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/auth_bloc/auth_event.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/auth_bloc/auth_state.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/sbloc_observer.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_bloc.dart';
import 'package:chat_app_bloc_flutter/locator.dart';
import 'package:chat_app_bloc_flutter/screens/verification_screen.dart';
import 'package:chat_app_bloc_flutter/screens/welcome_screen.dart';
import 'package:chat_app_bloc_flutter/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  Bloc.observer = SBlocObserver();
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => AuthBloc()..add(AuthStarted()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthFailure) {
              return WelcomeScreen();
            }
            if (state is AuthSuccess) {
              return BlocProvider(
                create: (context) => SigninBloc(),
                child: VerificationScreen(),
              );
            } else {
              return Scaffold(
                appBar: AppBar(),
                body: Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.greenAccent,
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
