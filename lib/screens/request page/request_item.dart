// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:desktop_project/component/special_button.dart';

class RequestItem extends StatefulWidget {
  Function() acceptOnTap;
  Function() rejectOnTap;
  final String name;
  final String phoneNumber;
  final String gender;
  final String birthDate;
  final String age;
  final String weight;
  RequestItem({
    Key? key,
    required this.acceptOnTap,
    required this.rejectOnTap,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.age,
    required this.weight,
    required this.birthDate,
  }) : super(key: key);

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  final Color _color2 = const Color(0xff1D397A);
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void _acceptRequest() async {
    // Save the request data to Firestore
    await _db.collection('requests').doc(widget.phoneNumber).set({
      'name': widget.name,
      'phoneNumber': widget.phoneNumber,
      'gender': widget.gender,
      'birthDate': widget.birthDate,
      'age': widget.age,
      'weight': widget.weight,
      'status': 'Accepted',
    });
    // Call the acceptOnTap function to update the UI
    widget.acceptOnTap();
  }

  void _rejectRequest() {
    // Call the rejectOnTap function to update the UI
    widget.rejectOnTap();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(5.0),
      width: width / 3.0,
      constraints: const BoxConstraints(minHeight: 100.0),
      decoration: BoxDecoration(
          color: const Color(0xffffffff),
          border: Border.all(
            color: const Color(0xff1D397A),
            width: 6.0,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Text(
            widget.name,
            style: TextStyle(
                color: _color2, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15.0,
          ),
          dataItem(
              key: "Phone Number",
              value: widget.phoneNumber,
              textColor: _color2),
          const SizedBox(
            height: 8.0,
          ),
          dataItem(
              key: "Weight", value: "${widget.weight} Kg", textColor: _color2),
          const SizedBox(
            height: 8.0,
          ),
          dataItem(
              key: "Birth Date", value: widget.birthDate, textColor: _color2),
          const SizedBox(
            height: 8.0,
          ),
          dataItem(key: "Gender", value: widget.gender, textColor: _color2),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialButton(
                bodyColor: const Color(0xffffffff),
                borderColor: const Color(0xff1D397A),
                text: 'Accept',
                onTap: _acceptRequest,
              ),
              SizedBox(
                width: width / 45.0,
              ),
              SpecialButton(
                borderColor: const Color(0xff1D397A),
                bodyColor: const Color(0xffffffff),
                text: 'Reject',
                onTap: _rejectRequest,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget dataItem(
      {required String key, required dynamic value, required Color textColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$key:  ",
            style: TextStyle(
              fontSize: 16.0,
              color: textColor,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
          ),
          Expanded(
            child: Container(
                constraints: const BoxConstraints(minHeight: 10.0),
                child: Text(
                  "${value}",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                )),
          )
        ],
      ),
    );
  }

  //
}
