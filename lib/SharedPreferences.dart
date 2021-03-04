import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//SharedPreferences
void main() => runApp(SharedPreferencesDemo());

class SharedPreferencesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Increment Counter'),
          ),
        ),
      ),
    );
  }
}

_incrementCounter() async {
  var prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $counter times.');
  prefs.setInt('counter', counter);
}
