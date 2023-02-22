
import 'package:chat_app_firebase/constants.dart';
import 'package:chat_app_firebase/models/ChatMessage.dart';
import 'package:flutter/material.dart';

import 'chat_input_field.dart';
import 'message.dart';
import 'text_message.dart';

class MessageBody extends StatefulWidget {
  final Function() onPressed;
  MessageBody({required this.onPressed});
  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: ChatMessages.length,
              itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.only(top: kDefaultPadding),
                    child: Message(
                      message: ChatMessages[index],
                    ),
                  )),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
