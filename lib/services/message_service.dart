import 'package:chat_app_bloc_flutter/models/message.dart';
import 'package:chat_app_bloc_flutter/models/user_model.dart';
import 'package:flutter/foundation.dart';

abstract class MessageService{
  Future<bool>send(Messages messages);
  Stream<Messages>? messages({required UserModel activeUser});
  dispose();
}
