import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_project/screens/chat%20page/chat%20component/chat_item.dart';
import 'package:desktop_project/screens/chat%20page/chat%20component/my_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'chat component/send_message.dart';
import 'chat component/user_message.dart';

class PersonalChat extends StatefulWidget {
  final String userName;
  final String userId;
  final String myEmail;
  final String userImage;

  PersonalChat({
    required this.userName,
    required this.myEmail,
    required this.userId,
    required this.userImage,
  });

  @override
  _PersonalChatState createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<ChatItem> _messages = [];
  
  get messageSnapshot => null;

  @override
  void initState() {
    super.initState();
    // Fetch message data from Firestore
    _fetchMessageData();
  }

  void _fetchMessageData() async {
    final messageSnapshot =
        await _db.collection('chats/${widget.userId}/messages').get();
    List<ChatItem> messages = [];
    messageSnapshot.docs.forEach((doc) {
      ChatItem message = ChatItem.fromJson(doc.data());
      messages.add(message);
    });
    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), topLeft: Radius.circular(25)),
        color: Colors.white,
      ),
      height: height,
      width: width * 2 / 3,
      child: Column(
        children: [
          //------------------- تصميم ال app bar-----------------
          // ...

          //------------------- نهاية ال app bar --------------------------------

          //------------------------------- الرسائل ---------------------------
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                ChatItem message = _messages[index];
                bool isMe = message.senderEmail == widget.myEmail;
                if (isMe) {
                  return MyMessage(
                    width: width,
                    context: context,
                    message: message.text,
                    time: message.time,
                  );
                } else {
                  return UserMessage(
                    width: width,
                    context: context,
                    message: message.text,
                    time: message.time,
                    messageSnapshot:messageSnapshot ,
                  );
                }
              },
            ),
          ),
          //---------------------------انتهاء دزاين الرسائل -------------------------

          //------------------------ تصميم مكان ارسال الرسائل -------------------------
          // ...
        ],
      ),
    );
  }
}