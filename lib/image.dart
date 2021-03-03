import 'package:flutter/material.dart';
import 'package:flutter_app/Constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Image',
        home: Center(
            child: Column(
          children: [
            Image.asset(
              "images/ic_test_head.jpg",
              width: 200,
              height: 200,
              alignment: Alignment.center,
            ),
            Text(
              Strings.welcomeMsg,
              style: TextStyle(color: Colors.white),
            )
          ],
        )));
  }
}
