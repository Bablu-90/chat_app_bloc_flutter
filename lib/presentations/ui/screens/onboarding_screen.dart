
import 'package:chat_app_bloc_flutter/color.dart';
import 'package:chat_app_bloc_flutter/utils/custom_text_field.dart';
import 'package:chat_app_bloc_flutter/utils/profile_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this);
  final TextEditingController nameController = TextEditingController();
  final String name = '';
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Lottie.asset(
                  'assets/images/24147-chat-animation.json',
                  controller: controller,
                  onLoaded: (composition) {
                    controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
                Spacer(),
                ProfileUpload(),
                Spacer(flex: 2),
                CustomTextField(
                    hint: 'What is Your Name?',
                    height: 45.0,
                    onChanged: (val) {
                      nameController.text = val;
                    },
                    inputAction: TextInputAction.done),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                      ),
                      onPressed: ()  {},
                      child: Container(
                          height: 45.0,
                          alignment: Alignment.center,
                          child: Text(
                            'Lets Chat',
                            style: Theme.of(context).textTheme.button!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ))),
                ),
                Spacer(flex: 2),

                SizedBox(
                  height: 10.0,
                )
              ],
            ),
          ),
        ));
  }
}
