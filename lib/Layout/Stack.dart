import 'package:flutter/material.dart';

void main() => runApp(StackDemo());

class StackDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StackPageState();
}

class StackPageState extends State<StackDemo> {
  var showCard = false;

  setShowCard() {
    setState(() {
      showCard = !showCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Layout',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack Layout'),
        ),
        body: Center(
          child: showCard ? _buildCard() : _buildStack(),
        ),
        floatingActionButton: FloatingActionButton(onPressed: ()=>{
          setShowCard(),
        }),
      ),
    );
  }
}

Widget _buildCard() => SizedBox(
      height: 210,
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            ListTile(
              title: Text('1625 Main Street',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('My City, CA 99984'),
              leading: Icon(
                Icons.restaurant_menu,
                color: Colors.blue[500],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('(408) 555-1212',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              leading: Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: Text('costa@example.com'),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );

Widget _buildStack() => Stack(
      //让文本偏移
      alignment: const Alignment(0.6, 0.6),
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('images/ic_test_head.jpg'),
          radius: 120,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black45),
          child: Text(
            'Mia B',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
