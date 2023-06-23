import 'package:flutter/material.dart';

class ClientData extends StatefulWidget {
  ClientData({
    super.key,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
  });

  String imagePath;
  String name;
  String email;
  String age;
  String gender;

  @override
  State<ClientData> createState() => _ClientDataState();
}

class _ClientDataState extends State<ClientData> {
  Color _color1 = const Color(0xff4170D8);
  Color _color2 = Colors.white;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(5),
      width: width / 3,
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
          border: Border.all(width: 6, color: const Color(0xff1C3879)),
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            height: 45,
            width: 45,
            child: widget.imagePath != 'null'
                ? CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.imagePath),
                  )
                : const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
          ),
        ),
        dataItem('Name', widget.name),
        dataItem('Email', widget.email),
        dataItem('phone', '${widget.age} '),
      ]),
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
