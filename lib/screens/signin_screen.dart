
import 'package:chat_app_bloc_flutter/bloc_state_management/auth_bloc/auth_bloc.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/auth_bloc/auth_event.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_bloc.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_event.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_state.dart';
import 'package:chat_app_bloc_flutter/constants.dart';
import 'package:chat_app_bloc_flutter/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../buttons/primary_button.dart';
import 'chat_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool get isPopulated =>
      _emailcontroller.text.isNotEmpty && _passwordcontroller.text.isNotEmpty;
  bool isButtonEnabled(SigninState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  SigninBloc? signinBloc;

  @override
  void initState() {
    super.initState();
    signinBloc = BlocProvider.of<SigninBloc>(context);
    _emailcontroller.addListener(() {
      return _onEmailChange();
    });
    _passwordcontroller.addListener(() {
      return _onPasswordChange();
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('SignIn Failure'),
                    Icon(Icons.error, color: Colors.black),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registering'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoggedIn(),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<SigninBloc, SigninState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: Column(
                children: <Widget>[
                  Spacer(flex: 2),
                  Image.asset(
                      MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? "assets/images/chat light.png.png"
                          : "assets/images/chat dark.png.png",
                      height: 146),
                  Spacer(),
                  TextFormField(
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        labelText: "Email",
                        hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (_) {
                      return state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordcontroller,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (_) {
                      return state.isPasswordValid ? 'Invalid Password' : null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      hintText: "Password",
                      labelText: "Password",
                    ),
                  ),
                  Spacer(),
                  PrimaryButton(
                    text: "Sign In",
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
                        builder: (context) => SignUpScreen(),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Register your account",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kDefaultPadding * 1.5),
                  Spacer(flex: 2)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    signinBloc!.add(SigninEmailChange(email: _emailcontroller.text));
  }

  void _onPasswordChange() {
    signinBloc!.add(SigninPasswordChanged(password: _passwordcontroller.text));
  }



  void _onFormSubmitted() {
    signinBloc!.add(SigninWithCredentialsPress(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        phoneNumber: _passwordcontroller.text));
  }
}
