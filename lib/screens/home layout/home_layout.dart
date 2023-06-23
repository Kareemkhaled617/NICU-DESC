// Mohamed Omar Khedr
import 'package:desktop_project/screens/chat%20page/chats.dart';
import 'package:desktop_project/screens/client%20page/clients.dart';
import 'package:desktop_project/screens/feedback%20page/feedback.dart';
import 'package:desktop_project/screens/home%20page/home_page.dart';

import 'package:desktop_project/screens/request%20page/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedItem = 0;
  Widget item = const HomePage();
  List<IconData> icons = [
    Icons.home,
    Icons.chat,
    Icons.person_3_rounded,
    Icons.request_quote_rounded,
    Icons.feedback,
    Icons.logout_outlined
  ];
  List<String> items = [
    'Home',
    'Clients',
    'Request',
    'Feedback',
    'Logout'
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            color: Color(0xFF1E3D7B),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: height,
                  width: width / 6,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 18,
                      ),
                      const Text(
                        'NICU',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SvgPicture.asset(
                        "asset/images/b.svg",
                        height: width / 10,
                        width: width / 10,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedItem = index;

                                  switch (index) {
                                    case 0:
                                      item = const HomePage();
                                      break;
                                    case 1:
                                      item = const Clients();
                                      break;
                                    case 2:
                                      item = const Requests();

                                      break;
                                    case 3:
                                      item = const FeedBack();
                                      break;
                                    case 4:
                                      logout();
                                      break;
                                  }
                                });
                              },
                              child: Container(
                                width: width / 6 - 24,
                                decoration: BoxDecoration(
                                    color: _selectedItem == index
                                        ? const Color(0xff5F7EAA)
                                        : null,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(left: 12, right: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      icons[index],
                                      color: _selectedItem == index
                                          ? Colors.white
                                          : const Color(0xff5F7EAA),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${items[index]}",
                                      style: TextStyle(
                                          color: _selectedItem == index
                                              ? Colors.white
                                              : const Color(0xff5F7EAA),
                                          fontWeight: _selectedItem == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        // الجزء التاني
        Container(
          width: width * 5 / 6 - 16,
          height: height - 16,
          margin:
              EdgeInsets.only(left: width * 1 / 6, right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(25)),
          child: item,
        )
      ],
    ));
  }

  Future<dynamic> logout() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          content: const Text('Are you sure that you want out?',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pushNamed(context, 'signIn');
              },
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
