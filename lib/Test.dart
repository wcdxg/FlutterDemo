import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
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
          body: BottomNavigationBar()),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(
                Icons.phone,
                color: Colors.blue,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'CALL',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.navigation,
                color: Colors.blue,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('ROUTE', style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.share,
                color: Colors.blue,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'SHARE',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
