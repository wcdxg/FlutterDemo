import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(Pavlova());

class Pavlova extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      home: buildHomePage('Strawberry Pavlova Recipe'),
    );
  }

  Widget buildHomePage(String title) {
    //左边列内容 Start--------------------------------------------

    //主标题
    final titleText = Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'Strawberry Pavlova',
        style: TextStyle(
            fontWeight: FontWeight.w800,
            //文字间距  可以使用负值
            letterSpacing: 0.5,
            fontSize: 30),
      ),
    );

    //副标题
    final subTitle = Text(
      'Pavlova is a meringue-based dessert named after the Russian ballerina '
      'Anna Pavlova. Pavlova features a crisp crust and soft, light inside, '
      'topped with fruit and whipped cream.',
      style: TextStyle(fontFamily: 'Georgia', fontSize: 25),
    );

    //评级-星星
    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star,color: Colors.green[500],),
        Icon(Icons.star,color: Colors.green[500],),
        Icon(Icons.star,color: Colors.green[500],),
        Icon(Icons.star,color: Colors.black,),
        Icon(Icons.star,color: Colors.black,),
      ],
    );

    //评级
    final ratings = Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stars,
          Text('170 Reviews',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
            letterSpacing: 0.5,
            fontSize: 20,
          ),)
        ],
      ),
    );

    final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 18,
      height: 2,
    );

    //DefaultTextStyle.merge() 允许你创建一个默认文本
    //被它的子节点和所有后续子节点继承的样式
    final iconList = DefaultTextStyle.merge(
        style: descTextStyle,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.kitchen,color: Colors.green[500],),
                  Text('PREP'),
                  Text('25 min')
                ],
              ),
              Column(
                children: [
                  Icon(Icons.timer,color: Colors.green[500],),
                  Text('COOK'),
                  Text('1 hr')
                ],
              ),
              Column(
                children: [
                  Icon(Icons.restaurant,color: Colors.green[500],),
                  Text('FEEDS'),
                  Text('4-6')
                ],
              ),
            ],
          ),
        ));

    final leftColumn = Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        children: [
          titleText,
          subTitle,
          ratings,
          iconList
        ],
      ),
    );
    //左边列内容 End--------------------------------------------


    //右边列内容->图片
    final mainImage = Image.asset(
      'images/pavlova.jpg',
      fit: BoxFit.cover,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
          height: 600,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 440,
                child: leftColumn,
              ),
              mainImage,
            ],
          ),
        ),
      ),
    );


  }
}
