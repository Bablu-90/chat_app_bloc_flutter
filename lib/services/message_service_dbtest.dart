import 'dart:async';

import 'package:chat_app_bloc_flutter/models/message.dart';
import 'package:chat_app_bloc_flutter/models/user_model.dart';
import 'package:chat_app_bloc_flutter/services/message_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessageServiceTest implements MessageService{

  final ref = FirebaseDatabase.instance.ref('test').child('messages');
   StreamSubscription changefeed;
  final controller = StreamController<Messages>.broadcast();
  MessageServiceTest({ required this.changefeed});
  @override
  dispose() {
    changefeed.cancel();
    controller.close();
  }

  @override
  Stream<Messages>? messages({required UserModel activeUser}) {
    startReceivingMessages(activeUser);
    return controller.stream;
  }

  @override
  Future<bool> send(Messages messages) async{
    final record = await FirebaseDatabase.instance.ref('test').child('messages').set(messages.toJson()).then((value) {
      print('value');
    }).catchError((onError){
      print(onError);
    });
    /*ref.table('messages').insert(messages.toJson()).run(connection);*/
    return record['inserted']==1;
  }

  void startReceivingMessages(UserModel activeUser) {
    changefeed =
        FirebaseDatabase.instance.ref('test').child('messages').orderByChild('to').equalTo(activeUser.id).onValue.asBroadcastStream().cast().listen((event) {event.forEach((element){
          print(element.snapshot.value);
          controller.sink.add(Messages.fromJson(element.snapshot.value));
        }).catchError((onError){
          print(onError);});
    /*run(connection).asStream();ref.table('messages').filter({'to':activeUser.id}).changes({'include_initial':true}).*/
      }

    );
  }


 void removeMessages(Messages messages)async{
    await FirebaseDatabase.instance.ref('test').child('messages').get().then((value) {
    FirebaseDatabase.instance.ref('test').child('messages').remove();
    }).catchError((onError){
      print(onError);
    });


  }
}
