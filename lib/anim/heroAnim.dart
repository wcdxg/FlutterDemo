import 'package:flutter/material.dart';

void main() => runApp(PhotoHero());

class PhotoHero extends StatelessWidget {
  PhotoHero({Key key, this.photo, this.onTap, this.width}) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
          tag: photo,
          child: Material(
            color: Colors.transparent,
            //InkWell 只能在Material的组建中使用
            child: InkWell(
              child: Image.asset(
                photo,
                //设置图像的 fit 属性到 BoxFit.contain，可以确保在过渡过程中尽可能放大，且不改变长宽比例
                fit: BoxFit.contain,
              ),
              onTap: onTap,
            ),
          )),
    );
  }
}
