import 'package:flutter/material.dart';

void main() => runApp(MyApp());
//ListView的创建以及动态添加数据
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView',
      home: MyListView(),
    );
  }
}

class MyListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(_getListView(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return _getListView(index);
        },
      ),
      drawer: Drawer(
        child: TextField(
          decoration: InputDecoration(hintText: 'This is a hint'),
        ),
      ),
    );
  }

  Widget _getListView(int i) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Row $i"),
      ),
      onTap: () {
        setState(() {
          //动态添加数据
          widgets.add(_getListView(widgets.length));
          print('row 点击的是第 $i 个');
        });
      },
    );
  }
}
