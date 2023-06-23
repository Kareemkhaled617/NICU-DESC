import 'package:desktop_project/component/button.dart';
import 'package:desktop_project/component/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({
    super.key,
  });

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  GlobalKey<FormState> formkey = GlobalKey();
  String? pass1;
  String? pass2;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            // النصف الأول من الشاشة
            Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: width / 2.0,
                  child: Stack(children: [
                    Container(color: Color(0xFF1C387A)),
                    //طباعة كلمة NICU
                    Container(
                      padding: EdgeInsets.only(left: 15.0, top: 50.0),
                      child: Transform.rotate(
                        angle: -0.785, // 45 degrees in radians
                        child: Text(
                          'NICU',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                    // صفحة تحديث كلمة السر
                    Container(
                      height: height,
                      width: width / 2.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(350)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // اضافة لوجو التطبيق
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: SvgPicture.asset(
                                  "asset/images/b.svg",
                                  height: 150.0,
                                  width: 150.0,
                                ),
                              ),

                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Reset Password',
                                        style: TextStyle(
                                          color: Color(0xFF233381),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0,
                                        ),
                                      ),
                                      Container(
                                        width: 200.0,
                                        child: Divider(
                                          height: 3.0,
                                          color: Color(0xFF233381),
                                          thickness: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              // text fields
                              Form(
                                key: formkey,
                                child: Container(
                                  width: 400.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyTextField(
                                        text: 'New Password',
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        prefixIcon: Icon(Icons.lock_rounded),
                                        obscureText: true,
                                        onChange: (value) {
                                          pass1 = value;
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return "The password can't be empty";
                                          } else if (value.length < 8) {
                                            return "The password can't be less than 8 letters";
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      MyTextField(
                                        text: 'Confirm new Password',
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        prefixIcon: Icon(Icons.lock_rounded),
                                        obscureText: true,
                                        onChange: (value) {
                                          pass2 = value;
                                          // confirm password
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return "The password can't be empty";
                                          } else if (value.length < 8) {
                                            return "The password can't be less than 8 letters";
                                          } else if (pass1 != pass2) {
                                            return "This password should equal the first password";
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      DefaultButton(
                                          text: 'Confirm',
                                          function: () {
                                            setState(() {});
                                            if (formkey.currentState!
                                                .validate()) {
                                              //
                                              Navigator.of(context)
                                                  .pushNamed("signIn");
                                            }
                                          },
                                          backGroundButton: Color(0xFF233381),
                                          textColor: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ]),
                ),
                Positioned(
                  top: 16.0,
                  left: width / 2.0 - width / 8.0,
                  child: Transform.rotate(
                    angle: -22.0 / 7.0, // 45 degrees in radians
                    child: FloatingActionButton(
                      backgroundColor: Color(0xFF1E3D7B),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                ),
              ],
            ),
            // النصف الثاني
            Spacer(),
            Container(
              height: double.infinity,
              width: width / 2.0,
              child: Stack(children: [
                semiCircle(
                    width: width / 2.0,
                    leftMargin: 0.0,
                    color: Color(0xFF54A6D8)),
                semiCircle(
                    width: width * 3.0 / 4.0,
                    leftMargin: width / 8.0,
                    color: Color(0xFF2D83B6)),
                semiCircle(
                    width: width / 4.0,
                    leftMargin: width / 4.0,
                    color: Color(0xFF005A92)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "asset/images/Medicine-bro (1).svg",
                            height: height / 2.0,
                            width: width / 5.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget semiCircle(
      {required double width, required leftMargin, required Color color}) {
    return Container(
      margin: EdgeInsets.fromLTRB(leftMargin, 0.0, 0.0, 0.0),
      height: double.infinity,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(left: Radius.circular(400.0))),
    );
  }
}
