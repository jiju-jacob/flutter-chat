import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: ((context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (chatSnapshot.data != null) {
            final chatDocs =
                chatSnapshot.data as QuerySnapshot<Map<String, dynamic>>;
            final currentUser = FirebaseAuth.instance.currentUser;
            return ListView.builder(
                reverse: true,
                itemCount: chatDocs.docs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                      chatDocs.docs[index]['text'],
                      chatDocs.docs[index]['userName'],
                      chatDocs.docs[index]['userId'] == currentUser?.uid,
                      ValueKey(chatDocs.docs[index].id),
                    ));
          }
          return SizedBox();
        }));
  }
}
