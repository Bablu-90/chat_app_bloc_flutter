
import 'package:chat_app_bloc_flutter/bloc_state_management/chatmessage_bloc/chatmessage_bloc.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/chatmessage_bloc/chatmessage_event.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/chatmessage_bloc/chatmessage_state.dart';
import 'package:chat_app_bloc_flutter/models/ChatMessage.dart';
import 'package:chat_app_bloc_flutter/models/chat_body.dart';
import 'package:chat_app_bloc_flutter/screens/messages/widgets/messagebody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatefulWidget {
  final Text text;
  final ChatMessage chatMessage;
  MessageScreen({required this.text, required this.chatMessage});
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    bool isMe = Text == ChatMessage.isSender;
    return Scaffold(
        appBar: buildAppBar(),
        body: BlocBuilder<ChatMessageBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoadSuccess) {
              List<ChatMessage> data = state.chatMessage;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, index) {
                    return ChatBody();
                  });
            } else if (state is ChatLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: isMe
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    color: isMe
                                        ? Theme.of(context).primaryColor
                                        : null,
                                    borderRadius: isMe
                                        ? BorderRadius.only(
                                            topRight: Radius.circular(20.0),
                                            topLeft: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                          )
                                        : BorderRadius.only(
                                            topRight: Radius.circular(20.0),
                                            topLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0),
                                          )),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.65,
                                  minHeight: 30,
                                ),
                                child: Text(
                                  ChatMessage.text,
                                  style: TextStyle(
                                      color:
                                          isMe ? Colors.white : Colors.black),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ChatBody();
                                  }));
                                },
                                child: MessageBody(onPressed: () {
                                  BlocProvider.of<ChatMessageBloc>(context).add(
                                    SendMessage(
                                      chatMessage: ChatMessage(
                                          text: 'Hey',
                                          messageType: ChatMessageType.text,
                                          messageStatus: MessageStatus.viewed,
                                          isSender: false),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              );
            }
          },
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(backgroundImage: AssetImage("assets/images/user 4.png")),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Text",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 10),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.local_phone)),
        IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
        SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }
}
