import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(primaryColor: Colors.blue),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SampleAppPageState();
}

class SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool showLoadingDialog() {
    return widgets.length == 0;
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        return getRow(index);
      },
    );
  }

  Widget getProgressDialog() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: getBody());
  }

  Widget getRow(int i) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Row ${widgets[i]["title"]}"));
  }

  Future<void> loadData() async {
    String dataUrl = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataUrl);
    setState(() {
      widgets = jsonDecode(response.body);
      log("请求成功 ${response.body}");
    });
  }
}
