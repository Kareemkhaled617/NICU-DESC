import 'package:desktop_project/screens/home%20layout/home_layout.dart';
import 'package:desktop_project/screens/sign%20in%20page/new_password.dart';
import 'package:desktop_project/screens/sign%20in%20page/reset_password.dart';
import 'package:desktop_project/screens/sign%20in%20page/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBXvBRZKwRZC4PRDkxZZ7mpE7u6KtJ9vek",
    appId: "1:641014388533:web:78f5633d02c33206511e7c",
    messagingSenderId: "641014388533",
    projectId: "nicu-52f6f",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NICU',
        home: const SignIn(),
        routes: {
          "signIn": (context) => const SignIn(),
          "resetPassword": (context) => const ResetPassword(),
          "newPassword": (context) => const NewPassword(),
          "homeLayout": (context) => HomeLayout(),
        },
      );
    });
  }
}
