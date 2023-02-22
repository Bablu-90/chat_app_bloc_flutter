
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_bloc.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_event.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/signin_bloc/signin_state.dart';
import 'package:chat_app_bloc_flutter/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool get isPopulated => _phoneNumberController.text.isNotEmpty;
  bool isButtonEnabled(SigninState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  SigninBloc? signinBloc;

  @override
  void initState() {
    super.initState();
    signinBloc = BlocProvider.of<SigninBloc>(context);
    _phoneNumberController.addListener(() {
      return _onPhoneNumberChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        elevation: 0,
        centerTitle: true,
        title: Text('Lets Connect'),
      ),
      body: BlocProvider<SigninBloc>(
        create: (context) => SigninBloc(),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                controller: _phoneNumberController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        )),
                    prefixIcon: Icon(
                      Icons.phone_android_rounded,
                      color: Colors.green.shade300,
                    ),
                    labelText: "Phone Number",
                    prefixText: "+971",
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    )),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.length != 12) {
                    return "Please enter a valid Phone Number";
                  }
                  return _phoneNumberController.text;
                },
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: 80,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(4),
                        ),
                        child: Text('Continue'))),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _onPhoneNumberChange() {
    signinBloc!
        .add(SigninPhoneNumberChange(phoneNumber: _phoneNumberController.text));
  }
}
