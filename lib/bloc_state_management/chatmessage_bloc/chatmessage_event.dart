

import 'package:chat_app_bloc_flutter/models/ChatMessage.dart';
import 'package:equatable/equatable.dart';

class ChatMessageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatLoad extends ChatMessageEvent {}

class SendMessage extends ChatMessageEvent {
  final ChatMessage chatMessage;

  SendMessage({required this.chatMessage});

  @override
  List<Object> get props => [chatMessage];
}

class ReceiveMessage extends ChatMessageEvent {
   List<ChatMessage> chatMessage;

  ReceiveMessage({required this.chatMessage});

  @override
  List<Object> get props => [chatMessage];
}
