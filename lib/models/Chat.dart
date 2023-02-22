
import 'package:flutter/material.dart';

import 'user_model.dart';

class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;
  final UserModel sender;

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

List chatsData = [
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/user 1 .png",
    time: "3m ago",
    isActive: false,
    sender: UserModel(
        id: 'id',
        name: 'name',
        lastSeen: DateTime.now(),
        email: 'email',
        profilePicLink: 'profilePicLink'),
  ),
  Chat(
      name: "Kristi Singh",
      lastMessage: "Hello Abdullah! I am...",
      image: "assets/images/user 2.png",
      time: "8m ago",
      isActive: true,
      sender: UserModel(
          id: 'id',
          name: 'name',
          lastSeen: DateTime.now(),
          email: 'email',
          profilePicLink: 'profilePicLink')),
  Chat(
      name: "Ralph Edwards",
      lastMessage: "Do you have update...",
      image: "assets/images/user_3.png",
      time: "5d ago",
      isActive: false,
      sender: UserModel(
          id: 'id',
          name: 'name',
          lastSeen: DateTime.now(),
          email: 'email',
          profilePicLink: 'profilePicLink')),
  Chat(
      name: "Jacob Jones",
      lastMessage: "You’re welcome :)",
      image: "assets/images/user 4.png",
      time: "5d ago",
      isActive: true,
      sender: UserModel(
          id: 'id',
          name: 'name',
          lastSeen: DateTime.now(),
          email: 'email',
          profilePicLink: 'profilePicLink')),
  Chat(
      name: "Rahul Sharma",
      lastMessage: "Thanks",
      image: "assets/images/user 6.png",
      time: "6d ago",
      isActive: false,
      sender: UserModel(
          id: 'id',
          name: 'name',
          lastSeen: DateTime.now(),
          email: 'email',
          profilePicLink: 'profilePicLink')),
  Chat(
      name: "Jenny Wilson",
      lastMessage: "Hope you are doing well...",
      image: "assets/images/user 5.png",
      time: "3m ago",
      isActive: false,
      sender: UserModel(
          id: 'id',
          name: 'name',
          lastSeen: DateTime.now(),
          email: 'email',
          profilePicLink: 'profilePicLink')),
  Chat(
      name: "Monty Khai-ra",
      lastMessage: "Hello Abdullah! I am...",
      image: "assets/images/user 6.png",
      time: "8m ago",
      isActive: true,
      sender: UserModel(
          id: 'id',
          name: 'name',
          lastSeen: DateTime.now(),
          email: 'email',
          profilePicLink: 'profilePicLink')),
  Chat(
      name: "Ralph Edwards",
      lastMessage: "Do you have update...",
      image: "assets/images/user image.png",
      time: "5d ago",
      isActive: false,
      sender: UserModel(
          id: 'id',
          name: 'name',
          lastSeen: DateTime.now(),
          email: 'email',
          profilePicLink: 'profilePicLink')),
];
