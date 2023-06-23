import 'package:flutter/material.dart';

class NumOfNICUs extends StatelessWidget {
  final String text;
  final int numOfNICUs;
  final Color color;
  const NumOfNICUs(
      {super.key,
      required this.text,
      required this.numOfNICUs,
      required this.color});

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 9,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          "$text :  $numOfNICUs",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
