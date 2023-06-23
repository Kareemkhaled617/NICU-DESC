import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatItem extends StatelessWidget {
  final bool isDoctorLastMessage;
  final String lastMessage;
  final String userName;
  final String timeLastMessage;
  final String userImage;
  final String userId;

  const ChatItem({
    Key? key,
    required this.isDoctorLastMessage,
    required this.lastMessage,
    required this.userName,
    required this.timeLastMessage,
    required this.userImage,
    required this.userId,
  }) : super(key: key);

  get senderEmail => null;

  get text => null;

  get time => null;

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
        "userId": userId,
        "isDoctorMessage": isDoctorLastMessage,
      });
    }

    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  height: 45,
                  width: 45,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("$userImage"),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$userName",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: double.infinity,
                        child: Row(
                          children: [
                            isDoctorLastMessage == true
                                ? Text(
                                    "You:",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black38),
                                  )
                                : Text(""),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Text(
                                "$lastMessage",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black38),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "$timeLastMessage",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.black38),
                  ),
                )
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            width: width / 3,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Divider(
              height: 0,
              indent: 0,
              endIndent: 0,
              color: Color(0xffE1E1E1),
            ),
          ),
          // Text field to send new message
          Container(
            margin: EdgeInsets.all(5),
            constraints: BoxConstraints(
              minHeight: 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
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
                    onFieldSubmitted: (value) {
                      addMessageToFirestore(
                          value); // Call addMessageToFirestore here
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_voice_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.image_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    addMessageToFirestore(
                        "Test message"); // Example of how to call addMessageToFirestore
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  factory ChatItem.fromJson(Map<String, dynamic> json) {
    return ChatItem(
      isDoctorLastMessage: json['isDoctorLastMessage'],
      lastMessage: json['lastMessage'],
      userName: json['userName'],
      timeLastMessage: json['timeLastMessage'],
      userImage: json['userImage'],
      userId: json['userId'],
    );
  }
}
