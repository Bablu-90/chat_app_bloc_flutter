


import 'package:firebase_database/firebase_database.dart';

Future<void>createDB(FirebaseDatabase ref) async{
  final db = FirebaseDatabase.instance.ref('test').child('users');
 /* await ref.dbCreate('test').run(connection);*/
  /*dbCreate('test').run(connection);*/
  /*await ref.table('users').run(connection);*/

 await  FirebaseDatabase.instance.ref().child('test').get().then((value) {
    print(value.value);
  }).catchError((onError){
    print(onError);
  });


 await FirebaseDatabase.instance.ref().child('users').get().then((value) {
    print(value.value);
  }).catchError((onError){
    print(onError);
  }
  );

  await FirebaseDatabase.instance.ref().child('messages').get().then((value) {
    print(value.value);
  }).catchError((onError){
    print(onError);
  }
  );


  }

  
  Future<void>cleanDB(FirebaseDatabase ref) async{
  await  FirebaseDatabase.instance.ref().child('users').remove().then((value) async {
     final db= FirebaseDatabase.instance.ref('test').child('users');
    db.remove();

    await FirebaseDatabase.instance.ref().child('messages').remove().then((value) {
      final db= FirebaseDatabase.instance.ref('test').child('messages');
      db.remove();
    }).catchError((onError){
      print(onError);
    }
    );
    /*ref.dbDrop('test').run(connection);*/
    /*ref.table('users').delete().run(connection);*/
  }
  ).catchError((onError){
    print(onError);
  });
  }
