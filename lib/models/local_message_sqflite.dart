

import 'package:chat_app_bloc_flutter/utils/chat_src.dart';

class LocalMessage{
  String chatId;
  String id;
  Messages messages;

  LocalMessage({
    required this.chatId,
    required this.id,
    required this.messages,
  });


  Map<String,dynamic>toMap()=>{
    'chatId':chatId,
    'id':messages.id,
    'messages':messages.toJson(),
  };

  factory LocalMessage.fromMap(Map<String,dynamic>json){
    final messages=Messages(
      from: json['messages']['from'],
      to: json['messages']['to'],
      timestamp: json['messages']['timestamp'],
      contents: json['messages']['contents'],
      id: '',

    );

    final localMessage = LocalMessage(
      chatId: json['chatId'],
      id: json['id'],
      messages: messages,

    );
    return localMessage;
  }
  }