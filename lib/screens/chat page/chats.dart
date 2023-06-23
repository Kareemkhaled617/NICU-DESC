import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_project/screens/chat%20page/chat%20component/chat_item.dart';
import 'package:desktop_project/screens/chat%20page/personal_chat.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatsState();
  }
}

class ChatsState extends State<Chats> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? userName;
  String? userId;
  String? myEmail;
  String? userImage;
  int _selectedChat = -1;
  List<ChatItem> _chatItems = [];

  @override
  void initState() {
    super.initState();
    // Fetch chat data from Firestore
    _fetchChatData();
  }

  void _fetchChatData() async {
    final chatSnapshot = await _db.collection('chats').get();
    List<ChatItem> chatItems = [];
    chatSnapshot.docs.forEach((doc) {
      ChatItem chatItem = ChatItem.fromJson(doc.data());
      chatItems.add(chatItem);
    });
    setState(() {
      _chatItems = chatItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          //كود الجزء الأول

          SizedBox(
            height: height - 16,
            width: width * 3 / 6,
            child: _selectedChat >= 0
                ? PersonalChat(
                    userId: userId != null ? userId! : "",
                    myEmail: 'myEmail',
                    userName: userName != null ? userName! : "",
                    userImage: userImage != null ? userImage! : "",
                  )
                : Center(
                    child: Image.asset(
                      "asset/images/ezgif.com-video-to-gif.gif",
                      height: height,
                      width: width / 2,
                    ),
                  ),
          ),
          // كود الجزء الثاني
          Container(
            height: height - 16,
            width: (width * 2 / 6 - 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    topRight: Radius.circular(25)),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.grey[100]!,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.grey[100]!,
                    ])),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 8, right: 10, left: 10),
                      child: const Text(
                        "Chats",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3D7B)),
                      ),
                    ),
                  ],
                ),

                //-------------------- محتوي ال chats ---------------------

                Expanded(
                  child: ListView.builder(
                    itemCount: _chatItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedChat = index;
                            userId = _chatItems[_selectedChat].userId;
                            myEmail = 'myEmail';
                            userName = _chatItems[_selectedChat].userName;
                            userImage = _chatItems[_selectedChat].userImage;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedChat == index
                                ? const Color(0xffE1E1E1)
                                : null,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _chatItems[index],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
