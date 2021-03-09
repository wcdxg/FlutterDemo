import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(GridViewDemo());

class GridViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView or ListView',
      home: GridViewPage(),
    );
  }
}

class GridViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GridViewState();
  }
}

class GridViewState extends State<GridViewPage> {
  var showGrid = true;

  setShowGrid() {
    setState(() {
      showGrid = !showGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView or ListView'),
      ),
      body: Center(
        child: showGrid ? _buildGrid() : _buildList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {setShowGrid()},
        child: Icon(
          Icons.grade,
          color: Colors.blue[300],
        ),
      ),
    );
  }
}

//GridView的两种常用创建方式
// 1.固定列数
Widget _buildGrid() => GridView.count(
      scrollDirection: Axis.vertical,
      children: _buildGridTileList(30),
      crossAxisCount: 3,
      padding: const EdgeInsets.all(4),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
    );

//2.设置item最大宽度 根据屏幕宽度自动计算列数
// Widget _buildGrid() => GridView.extent(
//       //最大宽度为150像素
//       maxCrossAxisExtent: 150,
//       padding: const EdgeInsets.all(4),
//       mainAxisSpacing: 4,
//       crossAxisSpacing: 4,
//       children: _buildGridTileList(30),
//       scrollDirection: Axis.vertical,
//     );

//生成一个List
List<Container> _buildGridTileList(int count) => List.generate(
    count,
    (index) => Container(
          child: Image.asset(
            'images/pavlova.jpg',
            fit: BoxFit.cover,
          ),
        ));

Widget _buildList() => ListView(
      scrollDirection: Axis.vertical,
      children: [
        _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
        _tile('The Castro Theater', '429 Castro St', Icons.theaters),
        _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
        _tile('Roxie Theater', '3117 16th St', Icons.theaters),
        _tile('United Artists Stonestown Twin', '501 Buckingham Way',
            Icons.theaters),
        _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
        //分割线
        Divider(color: Colors.red,),

        _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
        _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
        _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
        _tile('La Ciccia', '291 30th St', Icons.restaurant),
      ],
    );

ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
