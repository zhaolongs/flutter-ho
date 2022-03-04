import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
///
///
///
///
///
///
///
///
///
///
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoTransformImagePage(),
  ));
}

class DemoTransformImagePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DemoTransformImagePage>
    with SingleTickerProviderStateMixin {
  //图片资源
  List<String> _imageList = [
    "assets/images/p1.webp",
    "assets/images/p2.webp",
    "assets/images/p3.webp",
  ];
  int _select = 0;
  int _nextSelect = 0;
  late AnimationController _animationController;

  //上一次旋转结束位置
  double _rotateY = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //0.0~1.0
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );

    _animationController.addListener(() {
      if (_animationController.value > 0.5) {
        _nextSelect = _select;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transform")),
      body: Center(
        child: InkWell(
          onTap: () {
            if (_nextSelect != 0) {
              _rotateY += pi;
            }
            _animationController.forward(from: 0);
            setState(() {
              _select++;
            });
          },
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(
                _rotateY + pi * _animationController.value,
              ),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(
                  _nextSelect > 0 ? pi : 0,
                ),
              child: Image.asset(
                _imageList[_nextSelect % _imageList.length],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
