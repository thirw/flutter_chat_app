import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messeges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final document = snap.data.docs;

        return ListView.builder(
          reverse: true,
          itemCount: document.length,
          itemBuilder: (ctx, i) => MessageBubble(
            document[i]['text'],
            document[i]['username'],
            document[i]['userImage'],
            document[i]['userId'] == user.uid,
            key: ValueKey(
              document[i].id,
            ),
          ),
        );
      },
    );
  }
}

// StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('chats/DOHIfP0DKJ10jYjXIdaZ/messages')
//             .snapshots(),
//         builder: (ctx, AsyncSnapshot<QuerySnapshot> snap) {
//           if (snap.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final document = snap.data.docs;
//           return ListView.builder(
//             itemCount: document.length,
//             itemBuilder: (ctx, i) => Container(
//               padding: EdgeInsets.all(8),
//               child: Text(document[i]['text']),
//             ),
//           );
//         },
//       ),
