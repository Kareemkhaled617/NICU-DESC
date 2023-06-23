import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyMessage extends StatelessWidget {
  double width;
  BuildContext context;
  String message;
  String time;
  MyMessage({
    super.key,
    required this.width,
    required this.context,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _db =
        FirebaseFirestore.instance; // Create an instance of Firestore

    // Method to add message to Firestore database
    void addMessageToFirestore(String message) {
      // Create a new document in the "messages" collection with the message data
      _db.collection("messages").add({
        "text": message,
        "timestamp": FieldValue.serverTimestamp(),
      });
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: "$message"));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Text copied"),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFC0D0E9),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  "$message",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  overflow: TextOverflow.visible,
                ),
                constraints: BoxConstraints(
                  minHeight: 40,
                  maxWidth: width * 4 / 9 - 100,
                ),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.all(20),
              ),
            )
          ],
        ),

        //----------------------------------------------------

        //-------------------الوقت اسفل رسالة الدكتور ------------

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.all(2),
              child: Text(
                "$time",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            //  addMessageToFirestore(message),
          ],
          //  addMessageToFirestore(message),
        ),

        //----------------------------------------------------

        // Add message to Firestore database when message is built
        // addMessageToFirestore(message),
      ],
    );
    addMessageToFirestore(message);
  }
}
