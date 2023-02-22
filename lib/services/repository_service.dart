
import 'package:chat_app_bloc_flutter/models/ChatMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Chat.dart';
import '../models/user_model.dart';

class RepositoryService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel?> getUser(String id) async {
    final doc = await firebaseFirestore.collection('userModel').doc(id).get();

    if (doc.data != null) {
      return UserModel(
          id: doc.data()!['id'],
          email: doc.data()!['email'],
          name: doc.data()!['name'],
          lastSeen: doc.data()!['lastSeen'],
          profilePicLink: doc.data()!['Profile-pickLink']
      );
    }
    return null;
  }

  Future<void> registerUser(UserModel userModel) async {
    firebaseFirestore.collection('users').doc(userModel.id).set({
      'id': userModel.id,
      'email': userModel.email,
      'name': userModel.name,
      'lastSeen': userModel.lastSeen,
      'Profile-pickLink': userModel.profilePicLink,
    });
  }

  Future<void> setChat(Chat chat) async {
    return await firebaseFirestore
        .collection('chat')
        .doc(chat.name)
        .set(chat.toJson());
  }

  Future<DocumentSnapshot?> getChat(String name) async {
    await firebaseFirestore.collection('chat').doc(name).get();
  }

  Future<void> updateUserChatList(String id, String name) async {
    final chatListDoc =
        await firebaseFirestore.collection('user_model').doc(id).get();
    if (chatListDoc.exists) {
      return chatListDoc.reference.update({name: true});
    } else {
      return chatListDoc.reference.set({name: true});
    }
  }

  Future<Stream<DocumentSnapshot>>? getChatList(String id) {
    firebaseFirestore.collection('user_model').doc(id);
  }

  Stream<QuerySnapshot?> getChatMessages(String text) {
    return firebaseFirestore
        .collection('chat')
        .doc(text)
        .collection('messages')
        .orderBy('time', descending: false)
        .limit(20)
        .snapshots();
  }

  Stream<QuerySnapshot?> getChatInfo(List<String> chatName) {
    return firebaseFirestore.collection('chat').where('text').snapshots();
  }

  Future<void> sendChatMessage(String text, ChatMessage chatMessage) async {
    final ref = firebaseFirestore
        .collection('chat')
        .doc(text)
        .collection('messages')
        .doc(chatMessage.text);

    return firebaseFirestore.runTransaction((transaction) async {
      await transaction.set(ref, {
        'message': chatMessage.messageType,
        'isSender': chatMessage.isSender,
        'messageStatus': chatMessage.messageStatus,
      });
    });
  }

  Future<void> setChatLastMessage(String text, ChatMessage chatMessage) async {
    final ref = firebaseFirestore.collection('chat').doc(text);

    return firebaseFirestore.runTransaction((transaction) async {
      await transaction.update(ref, {
        'lastMessage': chatMessage.messageStatus,
        'lastModified': chatMessage.messageType,
      });
    });
  }
}
