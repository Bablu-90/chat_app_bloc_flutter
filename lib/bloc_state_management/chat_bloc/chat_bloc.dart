

import 'dart:async';


import 'package:chat_app_bloc_flutter/bloc_state_management/chat_bloc/chat_event.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/chat_bloc/chat_state.dart';
import 'package:chat_app_bloc_flutter/locator.dart';
import 'package:chat_app_bloc_flutter/models/Chat.dart';
import 'package:chat_app_bloc_flutter/models/user_model.dart';
import 'package:chat_app_bloc_flutter/services/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsDataBloc extends Cubit<ChatsDataState>{
  final UserModel userModel;
  ChatsDataBloc({required this.userModel,required this.chatsData,required this.chatsInfoData}): super(ChatsDataInitial());
  ChatService chatService = locator<ChatService>();
  StreamSubscription chatsData;
  StreamSubscription chatsInfoData;

  @override
 Stream<ChatsDataState> mapEventToState(ChatsDataEvent event)async*{
    if (event is ChatsDataStart){
      yield ChatsDataLoading();

      chatsData?.cancel();
      chatsData = chatService.getChatList(userModel.id).listen((chatsData){
        chatsInfoData?.cancel();
        if(chatsData.length == 0){
          add(ChatsDataLoad(chatsData:[]));
        }else{
             chatsInfoData = chatService.getChat(chatsData)!.listen((chatsData){
               add(ChatsDataLoad(chatsData:chatsData as List<Chat>));

        });
        }
        });
    }else if (event is ChatsDataLoad){
      yield* mapChatsDataLoadToState(event.chatsData);
    }else if (event is ChatsDataAdd){
      yield* mapChatsDataAddToState(event.name,event.name);
    }
  }

  Stream<ChatsDataState> mapChatsDataLoadToState(List<Chat> data)async*{
    data.sort((a,b){
      return b.lastMessage.compareTo(a.lastMessage);
    });
    yield ChatsDataLoadSuccess(chatsData: data);
  }

  Stream<ChatsDataState> mapChatsDataAddToState(String name,String time)async*{
    await chatService.addChatList(name, time);
    yield ChatsDataAddSuccess();
  }
  @override
  Future<void>close(){
    chatsData?.cancel();
    chatsInfoData?.cancel();
    return super.close();
  }

  mapChatsDataLoadsToState(List<Chat> chatsData) {
    return;
  }

  mapChatsDataAddsToState(String name) {
    return;
  }
}