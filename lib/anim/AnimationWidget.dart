import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

//动画
void main() => runApp(LogoApp());

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    print('AnimatedWidget创建');
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        child: FlutterLogo(),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) {
        print("$status");
        if(status == AnimationStatus.completed) {
          controller.reverse();
        } else if(status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
    ;
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print('build 创建');
    return AnimatedLogo(
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
