import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_project/screens/client%20page/client_data.dart';
import 'package:flutter/material.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: width * 5 / 6 - 16,
        height: height - 16,
        padding: EdgeInsets.fromLTRB(width / 22, 20, width / 22, 0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data?.docs as List;
              return GridView.count(
                crossAxisCount:
                    MediaQuery.of(context).size.width <= 1500 ? 1 : 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 2,
                childAspectRatio: 2.1,
                children: List.generate(
                    data.length,
                    (index) => ClientData(
                          imagePath: data[index]['image'],
                          name: data[index]['name'],
                          email: data[index]['email'],
                          age: data[index]['Phone'],
                          gender: '',
                        )),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
