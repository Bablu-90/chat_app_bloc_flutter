

import 'package:chat_app_bloc_flutter/bloc_state_management/chat_bloc/chat_bloc.dart';
import 'package:chat_app_bloc_flutter/bloc_state_management/chat_bloc/chat_state.dart';
import 'package:chat_app_bloc_flutter/constants.dart';
import 'package:chat_app_bloc_flutter/models/chat_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(),
      body: BlocBuilder<ChatsDataBloc,ChatsDataState>(
        builder: (context,state){
          return ChatBody();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage("assets/images/user 2.png"),
              ),
              label: "Profile"),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chats"),
        backgroundColor: kPrimaryColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))]);
  }
}
