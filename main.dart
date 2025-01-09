import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/game_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
          fontFamily: 'ArchitectsDaughter',
          scaffoldBackgroundColor: const Color.fromARGB(255, 175, 246, 177)),
      home: HomePage(),
    );
  }
}
