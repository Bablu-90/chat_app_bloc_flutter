import 'package:equatable/equatable.dart';

import '../../models/Chat.dart';

class ChatsDataState extends Equatable{
  @override
  List<Object> get props=> [];
}
class ChatsDataInitial extends ChatsDataState{}
class ChatsDataLoading extends ChatsDataState{}

class ChatsDataLoadSuccess extends ChatsDataState{
  final List<Chat> chatsData;

  ChatsDataLoadSuccess({required this.chatsData});

  @override
  List<Object> get props => [chatsData];
}

class ChatsDataAdding extends ChatsDataState{}
class ChatsDataAddSuccess extends ChatsDataState{}