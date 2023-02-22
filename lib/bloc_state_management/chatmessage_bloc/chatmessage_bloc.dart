import 'dart:async';



import 'package:chat_app_bloc_flutter/bloc_state_management/chatmessage_bloc/chatmessage_event.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/chatmessage_bloc/chatmessage_state.dart';
import 'package:chat_app_bloc_flutter/locator.dart';
import 'package:chat_app_bloc_flutter/models/user_model.dart';
import 'package:chat_app_bloc_flutter/services/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatState> {
  final UserModel userModel;
  final String text;

  ChatMessageBloc({required this.text, required this.userModel,required this.chatMessage})
      : super(ChatInitial());

  ChatService chatService = locator<ChatService>();

  StreamSubscription chatMessage;
  
  @override
  Stream<ChatState>mapEventToState(ChatMessageEvent event)async*{
    if(event is ChatLoad){
      yield ChatLoading();
      chatMessage?.cancel();
      chatMessage = chatService.getChatMessages(text)!.listen((chatMessage) {
        add(ReceiveMessage(chatMessage: chatMessage));
      });
    }else if (event is ReceiveMessage){
      yield ChatLoadSuccess(chatMessage: event.chatMessage);
    }else if (event is SendMessage){
      chatService.sendChatMessage(text, event.chatMessage);
      chatService.setChatLastMessage(text, event.chatMessage);
    }
  }

  @override
  Future<void> close(){
    chatMessage?.cancel();
    return super.close();
  }
}
