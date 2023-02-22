import 'dart:async';


import 'package:chat_app_bloc_flutter/locator.dart';
import 'package:chat_app_bloc_flutter/models/Chat.dart';
import 'package:chat_app_bloc_flutter/models/ChatMessage.dart';
import 'package:chat_app_bloc_flutter/models/user_model.dart';
import 'package:chat_app_bloc_flutter/services/repository_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatService {
  RepositoryService repositoryService = locator<RepositoryService>();

  Future<void> addChatList(String name, String time) async {
    final chatsData = await repositoryService.getChat(name);

    if (chatsData!.exists) {
      return repositoryService.updateUserChatList(time, name);
    } else {
      Chat newChats = Chat(
          name: name,
          lastMessage: '',
          image: '',
          time: DateTime.now().microsecondsSinceEpoch.toString(),
          isActive: true,
          sender: UserModel(
              id: 'id',
              name: name,
              lastSeen: DateTime.now(),
              email: '',
              profilePicLink: ''));

      await repositoryService.setChat(newChats);
      await repositoryService.updateUserChatList(time, name);
    }
  }

  Stream<List<Chat>>? getChat(List<String> chatName) {
    return repositoryService
        .getChatInfo(chatName)
        .transform(documentToChatTransformer);
  }

  StreamTransformer documentToChatTransformer =
      StreamTransformer<QuerySnapshot, List<Chat>>.fromHandlers(
          handleData: (QuerySnapshot snapShot, EventSink<List<Chat>> sink) {
    List<Chat> result = <Chat>[];
    snapShot.docs.forEach((doc) {
      result.add(Chat(
          name: doc['name'],
          lastMessage: doc['lastMessage'],
          image: doc['image'],
          time: doc['time'],
          isActive: doc['isActive'],
          sender: doc['sender']));
    });
    sink.add(result);
  });

  Future<Stream<DocumentSnapshot<Object?>>> getChatList(String id) {
    return repositoryService
        .getChatList(id)!
        .then((id) => documentToChatListTransformer.bind(id));
  }

  StreamTransformer documentToChatListTransformer =
      StreamTransformer<DocumentSnapshot, List<String>>.fromHandlers(handleData:
          (DocumentSnapshot snapShot, EventSink<List<String>> sink) {
    if (snapShot.exists) {
     sink.add(snapShot['chatList']);
    } else {
      sink.add([]);
    }
  });

  Stream<List<ChatMessage>>? getChatMessages(String text) {
    return repositoryService
        .getChatMessages(text)
        .transform(documentToChatMessagesTransformer);
  }

  StreamTransformer documentToChatMessagesTransformer =
      StreamTransformer<QuerySnapshot, List<ChatMessage>>.fromHandlers(
          handleData:
              (QuerySnapshot snapShot, EventSink<List<ChatMessage>> sink) {
    List<ChatMessage> result = <ChatMessage>[];
    snapShot.docs.forEach((doc) {
      result.add(ChatMessage(
          text: doc['text'],
          messageType: doc['messageType'],
          messageStatus: doc['messageStatus'],
          isSender: doc['isSender']));
    });
    sink.add(result);
  });

  documentToChatsListTransformer(String id) {
    return;
  }

  documentToChatsMessagesTransformer(
      List<ChatMessage> chatMessage, String text) {
    return;
  }

  Future<void> sendChatMessage(String text, ChatMessage chatMessage) async {
    return await repositoryService.sendChatMessage(text, chatMessage);
  }

  Future<void> setChatLastMessage(String text, ChatMessage chatMessage) async {
    return await repositoryService.setChatLastMessage(text, chatMessage);
  }
}
