import 'package:chat_app_bloc_flutter/models/Chat.dart';
import 'package:chat_app_bloc_flutter/models/local_message_sqflite.dart';

abstract class IDataSource{
  Future<void> addChat(Chat chat);
  Future<void>addMessage(LocalMessage message);
  Future<List<Chat>>getChats();
  Future<Chat>findChat(String chatId);
  Future<List<LocalMessage>>getMessages(String chatId);
  Future<void> updateMessage(LocalMessage message);
  Future<void>deleteChat(String chatId);
}