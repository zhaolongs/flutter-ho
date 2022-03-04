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
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DemoRotatedBoxPage(),
  ));
}

///代码清单
class DemoRotatedBoxPage extends StatefulWidget {
  @override
  _DemoRotatedBoxPageState createState() => _DemoRotatedBoxPageState();
}

class _DemoRotatedBoxPageState extends State<DemoRotatedBoxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RotatedBox 旋转"),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: Container(
        padding: EdgeInsets.only(top: 100, left: 100, right: 100),
        child: Row(
          children: [buildTransform()],
        ),
      ),
    );
  }

  buildTransform() {
    return Transform.rotate(
      //旋转的弧度
      angle: pi/2,
      //旋转的子Widget
      child: Container(
        child: Text(
          'Hello World!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey,
      ),
    );
  }

  buildRotate() {
    return RotatedBox(
      //旋转的倍数
      quarterTurns: 1,
      //旋转的子Widget
      child: Container(
        child: Text(
          'Hello World!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey,
      ),
    );
  }
}
