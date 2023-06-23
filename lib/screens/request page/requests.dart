import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_project/screens/request%20page/request_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  Future<List<Map<String, dynamic>>> getRequestData(String id) async {
    print("hi1");
    try {
      CollectionReference request = FirebaseFirestore.instance
          .collection('hospital')
          .doc(id)
          .collection('Request');

      QuerySnapshot snapshot = await request.get();
      List<QueryDocumentSnapshot> docs = snapshot.docs;

      List<Map<String, dynamic>> requestData = [];

      for (var doc in docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        requestData.add(data!);
      }

      return requestData;
    } catch (e) {
      throw Exception('Failed to get request data: $e');
    }
    print("hi2");
  }

  static Future<void> updateData() async {
    final data = {
      'name': 'Jane Doe',
      'email': 'janedoe@example.com',
      'age': 25,
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc('user1')
        .update(data);
  }

  static Future<void> deleteData() async {
    await FirebaseFirestore.instance.collection('users').doc('user1').delete();
  }



  static Stream<QuerySnapshot<Map<String, dynamic>>> getStreamData() {
    final stream = FirebaseFirestore.instance
        .collection('hospital')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Request')
        .where('isAccept', isEqualTo: 0)
        .snapshots();
    return stream;
  }
}

class _RequestsState extends State<Requests> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _requestsStream;

  @override
  void initState() {
    super.initState();
    try {
      _requestsStream = FirebaseService.getStreamData();
    } catch (e) {
      print('Error setting up stream: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 5.0 / 6.0 - 16.0,
      height: height - 16.0,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(25.0),
      ),
      padding: EdgeInsets.fromLTRB(width / 22.0, 20.0, width / 22.0, 0.0),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _requestsStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final requests = snapshot.data!.docs.map((doc) {
            return RequestItem(
              acceptOnTap: () async {
                await FirebaseFirestore.instance
                    .collection('hospital')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Request')
                    .doc(doc.id)
                    .set({'isAccept': 1}, SetOptions(merge: true));
              },
              rejectOnTap: () async {
                await FirebaseFirestore.instance
                    .collection('hospital')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Request')
                    .doc(doc.id)
                    .set({'isAccept': 2}, SetOptions(merge: true));
              },
              name: doc['Name'],
              phoneNumber: doc['phone'],
              gender: doc['Gender'],
              age: doc['Birthday'],
              weight: doc['Weight'],
              birthDate: doc['Birthday'],
            );
          }).toList();
          return ListView.builder(
            itemCount: (requests.length / 2.0).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  requests[index * 2],
                  if ((index * 2 + 1) < requests.length)
                    requests[index * 2 + 1],
                ],
              );
            },
          );
        },
      ),
    );
  }
}
