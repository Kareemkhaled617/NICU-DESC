import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserMessage extends StatelessWidget {
  double width;
  BuildContext context;
  DocumentSnapshot messageSnapshot;

  UserMessage({
    required this.width,
    required this.context,
    required this.messageSnapshot, required message, required time,
  });

  @override
  Widget build(BuildContext context) {
    // Extract the message data from the DocumentSnapshot
    String message = messageSnapshot['text'];
    String time = messageSnapshot['timestamp'].toString();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
                  color: Color(0xFF5F7EAA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  "$message",
                 style: TextStyle(fontSize: 14, color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
                constraints: BoxConstraints(
                  minHeight: 40,
                  maxWidth: width * 4 / 9 - 100,
                ),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.all(20),
              ),
            ),
          ],
        ),

        //----------------------------------------------------------

        //-------------------الوقت اسفل رسالة المستخدم ------------

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.all(2),
              child: Text(
                "$time",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}