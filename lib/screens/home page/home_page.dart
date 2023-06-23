import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_project/component/special_button.dart';
import 'package:desktop_project/screens/home%20page/child_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool display = false;
  bool display1 = false;
  bool display2 = false;
  bool? isAccept;
  List<ChildItem> _childItem = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<ChildItem>> _getChildData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('hospital')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Request')
        .get();
    final children = snapshot.docs.map((doc) {
      final data = doc.data();
      return ChildItem(
        name: data['Name'],
        age: data['Birthday'],
        gender: data['Gender'],
        documentId: doc.id,
        leftOnTap: () async {
          print(doc.id);
          await FirebaseService.updateChildStatus(doc.id, 'left');
          setState(() {
            _childItem.removeWhere((child) => child.documentId == doc.id);
          });
          Navigator.pop(context, false);
        }, eftOn: true,
      );
    }).toList();
    setState(() {
      _childItem = children;
    });
    return children;
  }

  Future<List<ChildItem>> _getAcceptChildData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('hospital')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Request')
        .where('isAccept', isEqualTo: 1)
        .get();
    final children = snapshot.docs.map((doc) {
      final data = doc.data();
      return ChildItem(
        name: data['Name'],
        age: data['Birthday'],
        gender: data['Gender'],
        documentId: doc.id,
        leftOnTap: () async {
          print(doc.id);
          await FirebaseService.updateChildStatus(doc.id, 'left');
          setState(() {
            _childItem.removeWhere((child) => child.documentId == doc.id);
          });
          Navigator.pop(context, false);
        }, eftOn: false,
      );
    }).toList();
    setState(() {
      _childItem = children;
    });
    return children;
  }

  Future<List<ChildItem>> _getRejectChildData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('hospital')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Request')
        .where('isAccept', isEqualTo: 2)
        .get();
    final children = snapshot.docs.map((doc) {
      final data = doc.data();
      return ChildItem(
        name: data['Name'],
        age: data['Birthday'],
        gender: data['Gender'],
        documentId: doc.id,
        leftOnTap: () async {
          print(doc.id);
          await FirebaseService.updateChildStatus(doc.id, 'left');
          setState(() {
            _childItem.removeWhere((child) => child.documentId == doc.id);
          });
          Navigator.pop(context, false);
        }, eftOn: false,
      );
    }).toList();
    setState(() {
      _childItem = children;
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          width: width * 5 / 6 - 16,
          constraints: const BoxConstraints(minHeight: 20),
          decoration: BoxDecoration(
              border: Border.all(width: 6, color: const Color(0xff1C3879)),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                  child: Text(
                "Number of NICUs",
                style: TextStyle(
                    color: Color(0xff1C3879),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
              Row(
                children: [
                  Expanded(
                      child: SpecialButton(
                    borderColor: const Color(0xff98ADCC),
                    bodyColor: display ? Colors.blue : Colors.white,
                    text: "All ",
                    onTap: () {
                      display = true;
                      display1 = false;
                      display2 = false;
                      setState(() {});
                    },
                    height: height / 9,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    borderRadius: 15,
                    textSize: 25,
                  )),
                  Expanded(
                      flex: 1,
                      child: SpecialButton(
                        borderColor: const Color(0xff98ADCC),
                        bodyColor: display1 ? Colors.blue : Colors.white,
                        text: "Accept ",
                        onTap: () {
                          display1 = true;
                          display = false;
                          display2 = false;
                          setState(() {});
                        },
                        height: height / 9,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(15),
                        borderRadius: 15,
                        textSize: 25,
                      )),
                  Expanded(
                      flex: 1,
                      child: SpecialButton(
                        borderColor: const Color(0xff98ADCC),
                        bodyColor: display2 ? Colors.blue : Colors.white,
                        text: "Reject ",
                        onTap: () {
                          display2 = true;
                          display = false;
                          display1 = false;
                          setState(() {});
                        },
                        height: height / 9,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(15),
                        borderRadius: 15,
                        textSize: 25,
                      )),
                ],
              )
            ],
          ),
        ),
        display == true
            ? Expanded(
                child: FutureBuilder(
                future: _getChildData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: width * 5 / 6 - 16,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 6, color: const Color(0xff1C3879)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                          width: width * 5 / 6 - 16,
                          height: height - 16,
                          padding: EdgeInsets.fromLTRB(
                              width / 22, 10, width / 22, 0),
                          child: Column(
                            children: [
                              const Center(
                                  child: Text(
                                "The children In NICUs",
                                style: TextStyle(
                                    color: Color(0xff1C3879),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: _childItem.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _childItem[index];
                                    }),
                              ),
                            ],
                          )),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
            : const SizedBox(),
        display1 == true
            ? Expanded(
                child: FutureBuilder(
                future: _getAcceptChildData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: width * 5 / 6 - 16,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 6, color: const Color(0xff1C3879)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                          width: width * 5 / 6 - 16,
                          height: height - 16,
                          padding: EdgeInsets.fromLTRB(
                              width / 22, 10, width / 22, 0),
                          child: Column(
                            children: [
                              const Center(
                                  child: Text(
                                "The children In NICUs",
                                style: TextStyle(
                                    color: Color(0xff1C3879),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: _childItem.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _childItem[index];
                                    }),
                              ),
                            ],
                          )),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
            : const SizedBox(),
        display2 == true
            ? Expanded(
                child: FutureBuilder(
                future: _getRejectChildData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: width * 5 / 6 - 16,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 6, color: const Color(0xff1C3879)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                          width: width * 5 / 6 - 16,
                          height: height - 16,
                          padding: EdgeInsets.fromLTRB(
                              width / 22, 10, width / 22, 0),
                          child: Column(
                            children: [
                              const Center(
                                  child: Text(
                                "The children In NICUs",
                                style: TextStyle(
                                    color: Color(0xff1C3879),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: _childItem.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _childItem[index];
                                    }),
                              ),
                            ],
                          )),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ))
            : const SizedBox()
      ],
    );
  }
}

class FirebaseService {
  static Future<void> updateChildStatus(
      String documentId, String status) async {
    await FirebaseFirestore.instance
        .collection('hospital')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Request')
        .doc(documentId)
        .delete();
  }
}
