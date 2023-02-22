
import 'package:chat_app_bloc_flutter/models/ChatMessage.dart';
import 'package:equatable/equatable.dart';

 class Chat extends Equatable{
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState{}

class ChatState {}
class ChatLoading extends ChatState{}

class ChatLoadSuccess extends ChatState{
  final List<ChatMessage> chatMessage;
  ChatLoadSuccess({required this.chatMessage});

  @override
  List<Object> get props => [chatMessage];
}

class ChatLoadFailure extends ChatState{}