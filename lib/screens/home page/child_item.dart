// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_project/component/special_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChildItem extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String documentId;
  final Function() leftOnTap;
  final bool eftOn;

  ChildItem({
    Key? key,
    required this.name,
    required this.age,
    required this.gender,
    required this.documentId,
    required this.leftOnTap,
    required this.eftOn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      width: width * 5 / 6 - 16,
      margin: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minHeight: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 12,
                child: Column(children: [
                  dataItem("Name", name),
                  dataItem("Age", "$age days"),
                  dataItem("Gender", gender),
                ]),
              ),
              eftOn
                  ? Expanded(
                      child: SpecialButton(
                        borderColor: const Color(0xff1C3879),
                        bodyColor: Colors.white,
                        text: "Left",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.blueGrey,
                                content: const Text(
                                    'Are you sure the child has left the NICU?',
                                    style: TextStyle(color: Colors.white)),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      leftOnTap();
                                    },
                                    child: const Text('Yes',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text('No',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            width: width * 5 / 6 - 40,
            child: const Divider(
              color: Color(0xFF1E3D7B),
              height: 10,
              thickness: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget dataItem(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$key: ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
          ),
          Expanded(
            child: Container(
                constraints: const BoxConstraints(minHeight: 10),
                child: Text(
                  "${value}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                )),
          )
        ],
      ),
    );
  }
}

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static Future<void> updateChildStatus(
      String documentId, String status) async {
    final data = {
      'status': status,
    };
    await FirebaseFirestore.instance
        .collection('children')
        .doc(documentId)
        .update(data);
  }
}
