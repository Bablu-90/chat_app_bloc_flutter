

import 'package:equatable/equatable.dart';

import '../../models/Chat.dart';

class ChatsDataEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class ChatsDataStart extends ChatsDataEvent{}
class ChatsDataLoad extends ChatsDataEvent{
  final List<Chat> chatsData;
  ChatsDataLoad({required this.chatsData});

  @override
  List<Object> get props => [chatsData];
}

class ChatsDataAdd extends ChatsDataEvent{
  final String name;

  ChatsDataAdd({required this.name});

  @override
  List<Object> get props => [name];
}