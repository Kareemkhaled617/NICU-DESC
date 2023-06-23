import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_project/screens/feedback%20page/feedback_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final List<FeedBackItem> _feedbackItem = [
    const FeedBackItem(
        feedbackMessage: "very good",
        nameClient: "Mohamed",
        feedbackTime: "12 march 2023",
        starsNumber: 5),
    const FeedBackItem(
        feedbackMessage: "good",
        nameClient: "Mostafa",
        feedbackTime: "13 march 2023",
        starsNumber: 4),
    const FeedBackItem(
        feedbackMessage: "This is very bad",
        nameClient: "Ahmed",
        feedbackTime: "13 march 2023",
        starsNumber: 1),
    const FeedBackItem(
        feedbackMessage: "good",
        nameClient: "Mohamed",
        feedbackTime: "14 march 2023",
        starsNumber: 3),
    const FeedBackItem(
        feedbackMessage: "very good",
        nameClient: "Mohamed",
        feedbackTime: "12 march 2023",
        starsNumber: 5),
    const FeedBackItem(
        feedbackMessage: "very good",
        nameClient: "Mohamed",
        feedbackTime: "12 march 2023",
        starsNumber: 5),
    const FeedBackItem(
        feedbackMessage: "very good",
        nameClient: "Mohamed",
        feedbackTime: "12 march 2023",
        starsNumber: 5),
    const FeedBackItem(
        feedbackMessage: "very good",
        nameClient: "Mohamed",
        feedbackTime: "12 march 2023",
        starsNumber: 5),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
        width: width * 5 / 6 - 16,
        height: height - 16,
        padding: EdgeInsets.fromLTRB(width / 22, 10, width / 22, 0),
        child: FutureBuilder(
          future:getReviews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FeedBackItem(
                        feedbackMessage: data[index]['review'],
                        nameClient: data[index]['name'],
                        feedbackTime: data[index]['date'],
                        starsNumber: data[index]['rate']);
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  getReviews() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('hospital')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('review')
        .get();
    return qn.docs;
  }
}
