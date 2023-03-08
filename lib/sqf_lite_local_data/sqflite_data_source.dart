import 'package:chat_app_bloc_flutter/models/Chat.dart';
import 'package:chat_app_bloc_flutter/models/local_message_sqflite.dart';
import 'package:chat_app_bloc_flutter/sqf_lite_local_data/data_source.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteDataSource implements IDataSource {
  final Database db;

  SqfLiteDataSource(this.db);

  @override
  Future<void> addChat(Chat chat) async {
    await db.insert('chats', chat.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> addMessage(LocalMessage message) async {
    await db.insert('messages', message.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteChat(String chatId) async {
    final batch = db.batch();
    batch.delete('messages', where: 'chat_id=?', whereArgs: [chatId]);
    batch.delete('chats', where: 'id=?', whereArgs: [chatId]);
    await batch.commit(noResult: true);
  }

  @override
  Future<Chat> findChat(String chatId) async {
    return db.transaction((txn) async {
      await txn.query('chats', where: 'id=?', whereArgs: [chatId]);
      final messages =
          await txn.query('messages', where: 'chat_id=?', whereArgs: [chatId]);
      var chat;
      chat.messages = messages.map((m) => LocalMessage.fromMap(m)).toList();
      return chat;
    });
  }

  @override
  Future<List<Chat>> getChats() {
    return db.transaction((txn) async {
      final chats = await txn.rawQuery('SELECT MESSAGES.*FROM'
          '('
          'SELECT chat_id,MAX(created_at)AS created_at'
          'FROM messages'
          'GROUP BY chat_id'
          ')AS LATEST_MESSAGES'
          'INNER JOIN messages'
          'ON messages.chat_id=LATEST_MESSAGES.chat_id'
          'AND messages.created_at=LATEST_MESSAGES.created_at'
          'INNER JOIN chats'
          'ON chats.id=messages.chat_id'
          'ORDER BY messages.created_at DESC');
      final chatsWithUnreadMessages = await txn
          .rawQuery('SELECT chats.*,COUNT(messages.id)AS unread_messages'
              'FROM chats'
              'LEFT JOIN messages'
              'ON messages.chat_id=chats.id'
              'AND messages.is_read=0'
              'GROUP BY chats.id');

      return chatsWithUnreadMessages.map((chat) {
        final chatWithUnreadMessages =
            chats.firstWhere((c) => c['id'] == chat['id']);
        return Chat.fromJson(chatWithUnreadMessages);
      }).toList();
    });
  }

  @override
  Future<List<LocalMessage>> getMessages(String chatId) async {
    final listOfMessages =
        await db.query('messages', where: 'chat_id=?', whereArgs: [chatId]);

    return listOfMessages.map((m) => LocalMessage.fromMap(m)).toList();
  }

  @override
  Future<void> updateMessage(LocalMessage message) async {
    await db.update('messages', message.toMap(),
        where: 'id=?',
        whereArgs: [message.messages.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
