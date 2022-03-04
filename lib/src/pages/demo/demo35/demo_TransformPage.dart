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
    home: DemoTransformPage(),
  ));
}

///代码清单
class DemoTransformPage extends StatefulWidget {
  @override
  _DemoTransformPageState createState() => _DemoTransformPageState();
}

class _DemoTransformPageState extends State<DemoTransformPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transform")),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.blue),
        ),
        child: buildScaleTransform(),
      ),
    );
  }

  ///缩放
  Widget buildScaleTransform() {
    return Transform.scale(
      //相对平移量
      origin: Offset(10, 0),
      //缩放中心
      alignment: Alignment(-1, 0),
      //缩放的大小
      scale: 0.5,
      child: buildImage(),
    );
  }

  ///平移
  Widget buildTransTransform() {
    return Transform.translate(
      //平移的距离
      offset: Offset(10, 100),
      child: buildImage(),
    );
  }

  ///旋转
  Widget buildRotateTransform() {
    return Transform.rotate(
      //旋转中心
      // alignment: Alignment.bottomRight,
      //相对于组件中心的一个偏移
      origin: Offset(-10, -10),
      //顺时针 弧度
      angle: pi,
      //旋转的组件
      child: buildImage(),
    );
  }

  Widget buildImage() {
    return Image.asset(
      "assets/images/banner1.png",
      height: 150,
    );
  }
}
