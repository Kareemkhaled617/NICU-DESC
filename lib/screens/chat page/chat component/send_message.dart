import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessage extends StatelessWidget {
  Function(String)? messageOnChanged;
  Function voiceOnPressed;
  Function imageOnPressed;
  Function sendOnPressed;

  SendMessage({
    super.key,
    required this.messageOnChanged,
    required this.voiceOnPressed,
    required this.imageOnPressed,
    required this.sendOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _db = FirebaseFirestore.instance; // Create an instance of Firestore

    void sendMessage(String message) async {
      // Create a new document in the "messages" collection with the message data
      await _db.collection("messages").add({
        "text": message,
        "timestamp": FieldValue.serverTimestamp(),
      });
    }

    return Container(
      margin: EdgeInsets.all(5),
      constraints: BoxConstraints(
        minHeight: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: messageOnChanged,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              minLines: 1,
              decoration: InputDecoration(
                hintText: "Type your message ...",
                hintStyle: TextStyle(
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                  gapPadding: 2,
                ),
                filled: true,
                fillColor: Color(0xFFC0D0E9),
              ),
            ),
          ),
           IconButton(
            onPressed: imageOnPressed(),
            icon: Icon(
              Icons.image_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ),
           IconButton(
            onPressed: () {
              // Call the sendMessage method with the current message text
              sendMessage(messageOnChanged!(""));
              sendOnPressed();
            },
            icon: Icon(
              Icons.send,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}