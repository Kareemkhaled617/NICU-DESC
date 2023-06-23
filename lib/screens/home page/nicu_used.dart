import 'package:flutter/material.dart';

class NICUUsed extends StatelessWidget {
  const NICUUsed({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      width: width * 5 / 6 - 16,
      margin: EdgeInsets.all(20),
      constraints: BoxConstraints(minHeight: 20),
      child: Column(children: [
        dataItem("Name", "Mohamed Omar"),
        dataItem("Age", "15"),
        dataItem("Gender", "male"),
        Container(
          width: width * 5 / 6 - 40,
          child: Divider(
            color: Color(0xFF1E3D7B),
            height: 20,
            thickness: 2,
          ),
        )
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
          ),
          Expanded(
            child: Container(
                constraints: BoxConstraints(minHeight: 10),
                child: Text(
                  "${value}",
                  style: TextStyle(
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
