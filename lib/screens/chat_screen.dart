import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/LXXVZJnEz3MHPa2qiqcj/messages')
              .snapshots(),
          builder: ((context, streamSnapshot) {
            if(streamSnapshot.connectionState == ConnectionState.waiting){
return Center(child: CircularProgressIndicator(),);
            }
            final documents = streamSnapshot.data as QuerySnapshot<Map<String, dynamic>>;
            return ListView.builder(
                itemCount: documents.docs.length,
                itemBuilder: ((context, index) {
                  return Text(documents.docs[index]['text']);
                }));
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
              .collection('chats/LXXVZJnEz3MHPa2qiqcj/messages').add({'text': 'this is new'});
          },
        ));
  }
}
