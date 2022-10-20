import 'package:easy_scrum/pages/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Scrum',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: "Comfortaa"),
      home: const LoginPage(),
    );
  }
}
