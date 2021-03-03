import 'package:flutter/material.dart';

void main() => runApp(MyApp());


/// 两种点击事件的处理
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture',
      home: MyAppPage(),
    );
  }
}

class MyAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return getItemWidget(index);
      },
    );
  }
}

Widget getItemWidget(int i) {
  if (i == 0) {
    return ElevatedButton(
        onPressed: () {
          print('click');
        },
        child: Text('Button'));
  } else {
    return Center(
      child: GestureDetector(
        child: FlutterLogo(
          size: 200.0,
        ),
        onTap: () {
          print('tap');
        },
      ),
    );
  }
}
