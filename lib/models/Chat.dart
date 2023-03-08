


import 'package:chat_app_bloc_flutter/models/local_message_sqflite.dart';

import 'user_model.dart';

class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;
  final UserModel sender;
  List<LocalMessage> messages = [];

  Chat({
    required this.name,
    required this.lastMessage,
    required this.image,
    required this.time,
    required this.isActive,
    required this.sender,
  });

  //from JSON
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      name: json['name'],
      lastMessage: json['lastMessage'],
      image: json['image'],
      time: json['time'],
      isActive: json['isActive'],
      sender: UserModel.fromJson(json['sender']),
    );
  }

  //to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'lastMessage': lastMessage,
        'image': image,
        'time': time,
        'isActive': isActive,
        'sender': sender.toJson(),
      };
}


