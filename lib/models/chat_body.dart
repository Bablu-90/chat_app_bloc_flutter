import 'dart:convert';


import 'package:chat_app_bloc_flutter/models/ChatMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../screens/message_screen.dart';
import 'Chat.dart';
import 'chat_card.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              'Chat App',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Chat").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Chat> chatsData = snapshot.data!.docs.map((e) {
                      return Chat.fromJson(jsonDecode(jsonEncode(e.data())));
                    }).toList();
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: chatsData.length,
                      itemBuilder: ((context, index) => ChatCard(
                            chat: chatsData[index],
                            press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessageScreen(
                                    text: Text(''),
                                    chatMessage: ChatMessage(
                                        text: 'Hello',
                                        messageType: ChatMessageType.text,
                                        messageStatus: MessageStatus.viewed,
                                        isSender: false)),
                              ),
                            ),
                          )),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.green.shade100,
                        backgroundImage:
                            AssetImage('assets/images/user image.png'),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
