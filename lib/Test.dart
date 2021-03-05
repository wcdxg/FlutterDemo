import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'menu',
            onPressed: null,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: null,
              tooltip: 'search',
            )
          ],
        ),
        body: Center(
          child: Image.asset(
            'images/ic_test_head.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
