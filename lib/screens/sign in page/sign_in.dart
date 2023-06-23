import 'package:desktop_project/component/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../component/button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String _password = "";
  String _email = "";

  void SignIn() async {
    if (formkey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        Navigator.of(context).pushNamed("homeLayout");
      } catch (e) {
        print(e);
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential as GoogleAuthCredential);
    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Check if login was successful
    if (result.status != LoginStatus.success) {
      return null;
    }

    // Create a new credential
    final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  // Future<UserCredential?> signInWithTwitter() async {
  //   // Trigger the sign-in flow
  //   final TwitterLoginResult result = await TwitterLogin(
  //     consumerKey: 'your_consumer_key',
  //     consumerSecret: 'your_consumer_secret',
  //   ).authorize();

  //   // Check if login was successful
  //   if (result.status != TwitterLoginStatus.loggedIn) {
  //     return null;
  //   }

    // Create a new credential
   // final TwitterSession session = result.session;
  //   final OAuthCredential credential = TwitterAuthProvider.credential(
  //     accessToken: session.token,
  //     secret: session.secret,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await _auth.signInWithCredential(credential);
  // }

  late double width;
  late double height;
  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            // النصف الأول من الشاشة
            Form(
              key: formkey,
              child: SizedBox(
                height: double.infinity,
                width: width / 2.0,
                child: Stack(children: [
                  Container(color: const Color(0xFF1C387A)),
                  //طباعة كلمة NICU
                  Container(
                    padding: const EdgeInsets.only(left: 15.0, top: 50.0),
                    child: Transform.rotate(
                      angle: -0.785, // 45 degrees in radians
                      child: const Text(
                        'NICU',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ),
                  // صفحة تسجيل الدخول
                  Container(
                    height: height,
                    width: width / 2.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(350.0)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // اضافة لوجو التطبيق
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: SvgPicture.asset(
                                "asset/images/b.svg",
                                height: 150.0,
                                width: 150.0,
                              ),
                            ),

                            //طباعة كلمة Welcome
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: const Text(
                                'Welcome ...',
                                style: TextStyle(
                                  color: Color(0xFF090909),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0,
                                ),
                              ),
                            ),

                            // كلمة تسجيل الدخول
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                        color: Color(0xFF233381),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120.0,
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
                            const SizedBox(
                              height: 30.0,
                            ),
                            // text fields
                            Container(
                              child: SizedBox(
                                width: 400.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MyTextField(
                                      text: 'Email',
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon:
                                          const Icon(Icons.email_outlined),
                                      onChange: (value) {
                                        //email
                                        _email = value;
                                      },
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return "The email can't be empty";
                                        }
                                      },
                                    ),
                                    MyTextField(
                                      text: 'Password',
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      prefixIcon:
                                          const Icon(Icons.lock_rounded),
                                      obscureText: true,
                                      onChange: (value) {
                                        //password
                                        _password = value;
                                      },
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return "The password can't be empty";
                                        }
                                      },
                                    ),

                                    InkWell(
                                      onTap: () {
                                        //forget Password
                                        Navigator.of(context)
                                            .pushNamed("resetPassword");
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Text('forget password'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    DefaultButton(
                                        text: 'SIGN IN',
                                        function: () {
                                          SignIn();

                                          setState(() {});
                                          if (formkey.currentState!
                                              .validate()) {
                                            //
                                            Navigator.of(context)
                                                .pushNamed("homeLayout");
                                          }
                                        },
                                        backGroundButton:
                                            const Color(0xFF233381),
                                        textColor: Colors.white),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    // sign in with
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Expanded(
                                          child: Divider(
                                              color: Color(0xFFBBBBBB),
                                              height: 10.0,
                                              thickness: 1.5),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          'Sign in with',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Expanded(
                                          child: Divider(
                                              color: Color(0xFFBBBBBB),
                                              height: 10.0,
                                              thickness: 1.5),
                                        ),
                                      ],
                                    ),

                                    // أيقونات السوشيال ميديا

                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40.0,
                                          width: 40.0,
                                          child: InkWell(
                                            onTap: () {
                                              signInWithGoogle();
                                              // gmail ;
                                            },
                                            child: Image.asset(
                                              'asset/Images/2.png',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                          width: 40.0,
                                          child: InkWell(
                                            onTap: () {
                                              signInWithFacebook();
                                              // facebook
                                            },
                                            child: Image.asset(
                                              'asset/Images/1.svg.png',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Container(
                                          height: 40.0,
                                          width: 40.0,
                                          child: InkWell(
                                            onTap: () {
                                              //signInWithTwitter();
                                              // twitter
                                            },
                                            child: Image.asset(
                                              'asset/Images/3.webp',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ]),
              ),
            ),
            // النصف الثاني
            const Spacer(),
            SizedBox(
              height: double.infinity,
              width: width / 2.0,
              child: Stack(children: [
                semiCircle(
                    width: width / 2.0,
                    leftMargin: 0.0,
                    color: const Color(0xFF54A6D8)),
                semiCircle(
                    width: width * 3.0 / 4.0,
                    leftMargin: width / 8.0,
                    color: const Color(0xFF2D83B6)),
                semiCircle(
                    width: width / 4.0,
                    leftMargin: width / 4.0,
                    color: const Color(0xFF005A92)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "asset/images/Medicine-bro (1).svg",
                          height: height / 2.0,
                          width: width / 5.0,
                        ),
                      ],
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
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(400.0))),
    );
  }
}
